#!/usr/bin/env python3

import os
import sys
import git
import glob
import shutil
from pathlib import Path
from jarvis_util.shell.exec import Exec
from jarvis_util.shell.local_exec import LocalExecInfo

class GitUrl:
    """Class to handle GitHub URLs for both HTTPS and SSH access"""
    def __init__(self, username: str, package_name: str):
        self.url_https = f"https://github.com/{username}/{package_name}.git"
        self.url_ssh = f"git@github.com:{username}/{package_name}.git"

class IowarpClone:
    """Main class to handle IOWarp repository operations"""
    def __init__(self):
        self.iowarp_dir = os.getenv('IOWARP')
        if not self.iowarp_dir:
            print("Error: IOWARP environment variable not set")
            sys.exit(1)
        self.iowarp_dir = Path(self.iowarp_dir)

    def check_clone_marker(self):
        """Check if .iowarp-clone marker exists"""
        marker = self.iowarp_dir / '.iowarp-clone'
        if not marker.exists():
            print("Error: IOWARP/.iowarp-clone does not exist. Are you sure that clone was used properly?")
            sys.exit(1)

    def get_package_names(self):
        """Get list of package names from iowarp-spack/packages"""
        packages_dir = Path(__file__).parent / 'iowarp-spack' / 'packages'
        return [d.name for d in packages_dir.iterdir() if d.is_dir()]

    def clone(self, username='iowarp', core_dev=False):
        """Clone all IOWarp repositories"""
        self.iowarp_dir.mkdir(parents=True, exist_ok=True)
        (self.iowarp_dir / '.iowarp-clone').touch()

        for pkg_name in self.get_package_names():
            target_dir = self.iowarp_dir / pkg_name
            if target_dir.exists():
                print(f"Directory {target_dir} already exists, skipping...")
                continue

            urls = GitUrl(username, pkg_name)
            success = False

            # Try user's SSH URL first if username is not iowarp
            if username != 'iowarp':
                try:
                    git.Repo.clone_from(urls.url_ssh, target_dir)
                    success = True
                except git.exc.GitCommandError:
                    print(f"Failed to clone {pkg_name} using SSH URL for {username}")

            # Try iowarp URLs if first attempt failed
            if not success:
                try:
                    url = urls.url_ssh if core_dev else urls.url_https
                    git.Repo.clone_from(url, target_dir)
                    success = True
                except git.exc.GitCommandError:
                    print(f"Warning: Failed to clone {pkg_name} from iowarp")

    def pull(self, remote="", branch=""):
        """Pull updates in all repositories"""
        self.check_clone_marker()
        
        for repo_dir in self.iowarp_dir.iterdir():
            if not repo_dir.is_dir() or repo_dir.name.startswith('.'):
                continue
            
            try:
                repo = git.Repo(repo_dir)
                cmd = ['git', 'pull']
                if remote:
                    cmd.append(remote)
                if branch:
                    cmd.append(branch)
                
                Exec(' '.join(cmd), LocalExecInfo(cwd=str(repo_dir)))
                print(f"Successfully pulled {repo_dir.name}")
            except git.exc.InvalidGitRepositoryError:
                print(f"Warning: {repo_dir} is not a git repository")
            except Exception as e:
                print(f"Error pulling {repo_dir}: {str(e)}")

    def env(self):
        """Source env.sh files in repositories"""
        self.check_clone_marker()
        
        for repo_dir in self.iowarp_dir.iterdir():
            env_file = repo_dir / 'env.sh'
            if env_file.exists():
                try:
                    Exec(f"source {env_file}", LocalExecInfo(cwd=str(repo_dir)))
                    print(f"Sourced env.sh in {repo_dir.name}")
                except Exception as e:
                    print(f"Error sourcing env.sh in {repo_dir}: {str(e)}")

    def setup(self):
        """Setup development environment"""
        self.check_clone_marker()
        home_dir = str(Path.home())
        
        for repo_dir in self.iowarp_dir.iterdir():
            if not repo_dir.is_dir():
                continue
                
            vscode_dir = repo_dir / '.vscode'
            if vscode_dir.exists():
                presets_file = vscode_dir / 'CMakePresets.yaml'
                if presets_file.exists():
                    # Read and replace home directory
                    with open(presets_file, 'r') as f:
                        content = f.read().replace('/home/llogan', home_dir)
                    
                    # Write to root directory
                    with open(repo_dir / 'CMakePresets.yaml', 'w') as f:
                        f.write(content)
                    print(f"Copied and updated CMakePresets.yaml for {repo_dir.name}")
        
        # Re-run env setup
        self.env()

    def build(self, preset=None):
        """Build repositories"""
        self.check_clone_marker()
        
        for repo_dir in self.iowarp_dir.iterdir():
            cmake_file = repo_dir / 'CMakeLists.txt'
            if cmake_file.exists():
                build_dir = repo_dir / 'build'
                build_dir.mkdir(exist_ok=True)
                
                cmd = ['cmake', '..']
                if preset:
                    cmd.extend(['--preset', preset])
                
                try:
                    Exec(' '.join(cmd), LocalExecInfo(cwd=str(build_dir)))
                    Exec('cmake --build .', LocalExecInfo(cwd=str(build_dir)))
                    print(f"Successfully built {repo_dir.name}")
                except Exception as e:
                    print(f"Error building {repo_dir}: {str(e)}")

    def install(self, preset=None):
        """Install built repositories"""
        self.check_clone_marker()
        
        for repo_dir in self.iowarp_dir.iterdir():
            build_dir = repo_dir / 'build'
            if build_dir.exists():
                cmd = ['cmake', '--install', '.']
                if preset:
                    cmd.extend(['--preset', preset])
                
                try:
                    Exec(' '.join(cmd), LocalExecInfo(cwd=str(build_dir)))
                    print(f"Successfully installed {repo_dir.name}")
                except Exception as e:
                    print(f"Error installing {repo_dir}: {str(e)}")

    def clear(self):
        """Clear build directories"""
        self.check_clone_marker()
        
        for repo_dir in self.iowarp_dir.iterdir():
            build_dir = repo_dir / 'build'
            if build_dir.exists():
                try:
                    shutil.rmtree(build_dir)
                    print(f"Cleared build directory for {repo_dir.name}")
                except Exception as e:
                    print(f"Error clearing build directory for {repo_dir}: {str(e)}")

def main():
    """Main entry point"""
    if len(sys.argv) < 2:
        print("Usage: iowarp-clone <command> [args...]")
        sys.exit(1)

    command = sys.argv[1]
    iowarp = IowarpClone()

    if command == 'clone':
        username = sys.argv[2] if len(sys.argv) > 2 else 'iowarp'
        core_dev = sys.argv[3].lower() == 'true' if len(sys.argv) > 3 else False
        iowarp.clone(username, core_dev)
    elif command == 'pull':
        remote = sys.argv[2] if len(sys.argv) > 2 else ""
        branch = sys.argv[3] if len(sys.argv) > 3 else ""
        iowarp.pull(remote, branch)
    elif command == 'setup':
        iowarp.setup()
    elif command == 'env':
        iowarp.env()
    elif command == 'build':
        preset = sys.argv[2] if len(sys.argv) > 2 else None
        iowarp.build(preset)
    elif command == 'install':
        preset = sys.argv[2] if len(sys.argv) > 2 else None
        iowarp.install(preset)
    elif command == 'clear':
        iowarp.clear()
    else:
        print(f"Unknown command: {command}")
        sys.exit(1)

if __name__ == '__main__':
    main() 