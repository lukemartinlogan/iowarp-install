from spack.package import *


class IowarpCae(CMakePackage):
    homepage = "https://grc.iit.edu/docs/hermes/main-scenario"
    git = "https://github.com/iowarp/content-assimilation-engine.git"

    version(
        "main",
        branch="main",
        git="https://github.com/iowarp/content-assimilation-engine.git",
        preferred=True,
    )
    version(
        "dev", branch="dev",
        git="https://github.com/iowarp/content-assimilation-engine.git"
    )
    version("priv", branch="main",
            git="https://github.com/iowarp/content-assimilation-engine.git")

    # Common variants
    variant("posix", default=True, description="Enable POSIX adapter")
    variant("mpiio", default=True, description="Enable MPI I/O adapter")
    variant("stdio", default=True, description="Enable STDIO adapter")
    variant("debug", default=False, description="Build shared libraries")
    variant("vfd", default=False, description="Enable HDF5 VFD")
    variant(
        "nocompile",
        default=False,
        description="Do not compile the library (used for dev purposes)",
    )
    variant("depsonly", default=False, description="Only install dependencies")

    # MPI variants
    variant("mpich", default=False, description="Build with MPICH")
    variant("openmpi", default=False, description="Build with OpenMPI")

    depends_on("content-transfer-engine") 
    depends_on('iowarp-base')

    # GPU variants
    variant("cuda", default=False, description="Enable CUDA support for iowarp")
    variant("rocm", default=False, description="Enable ROCm support for iowarp")
    depends_on("iowarp-runtime+cuda", when="+cuda")
    depends_on("iowarp-runtime+rocm", when="+rocm")

    def cmake_args(self):
        args = []
        if "+debug" in self.spec:
            args.append("-DCMAKE_BUILD_TYPE=Debug")
        else:
            args.append("-DCMAKE_BUILD_TYPE=Release")
        if "+posix" in self.spec:
            args.append("-DCAE_ENABLE_POSIX_ADAPTER=ON")
        if "+mpiio" in self.spec:
            args.append("-DCAE_ENABLE_MPIIO_ADAPTER=ON")
            if "+openmpi" in self.spec:
                args.append("-DCAE_OPENMPI=ON")
            elif "+mpich" in self.spec:
                args.append("-DCAE_MPICH=ON")
        if "+stdio" in self.spec:
            args.append("-DCAE_ENABLE_STDIO_ADAPTER=ON")
        if "+vfd" in self.spec:
            args.append("-DCAE_ENABLE_VFD=ON")
        if "+nocompile" in self.spec or "+depsonly" in self.spec:
            args.append(self.define("CAE_NO_COMPILE", "ON"))
        if "+cuda" in self.spec:
            args.append(self.define("CAE_ENABLE_CUDA", "ON"))
        if "+rocm" in self.spec:
            args.append(self.define("CAE_ENABLE_ROCM", "ON"))
        return args

    def setup_run_environment(self, env):
        # This is for the interceptors
        env.prepend_path("LD_LIBRARY_PATH", self.prefix.lib)
        env.prepend_path("PYTHONPATH", self.prefix.lib)
        env.prepend_path('CMAKE_MODULE_PATH', self.prefix.cmake)
        env.prepend_path('CMAKE_PREFIX_PATH', self.prefix.cmake) 