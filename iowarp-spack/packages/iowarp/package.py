from spack.package import *


class Iowarp(Package):
    homepage = "https://grc.iit.edu/docs/hermes/main-scenario"
    git = "https://github.com/iowarp/content-transfer-engine.git"
    phases = []

    version(
        "main",
        branch="main",
        git="https://github.com/iowarp/content-transfer-engine.git",
        preferred=True,
    )
    version(
        "dev", branch="dev",
        git="https://github.com/iowarp/content-transfer-engine.git"
    )
    version("priv", branch="dev",
            git="https://github.com/lukemartinlogan/hermes.git")

    # Common variants
    variant("posix", default=True, description="Enable POSIX adapter")
    variant("mpiio", default=True, description="Enable MPI I/O adapter")
    variant("stdio", default=True, description="Enable STDIO adapter")
    variant("debug", default=False, description="Build shared libraries")
    variant("vfd", default=False, description="Enable HDF5 VFD")
    variant("ares", default=False, description="Enable full libfabric install")
    variant("encrypt", default=False,
            description="Include encryption libraries")
    variant("compress", default=False,
            description="Include compression libraries")
    variant("python", default=False, description="Install python bindings")
    variant(
        "nocompile",
        default=False,
        description="Do not compile the library (used for dev purposes)",
    )
    variant("depsonly", default=False, description="Only install dependencies")
    variant("ppi", default=True, description="Force install ppi")

    # MPI variants
    variant("mpich", default=False, description="Build with MPICH")
    variant("openmpi", default=False, description="Build with OpenMPI")

    depends_on("iowarp-cte")
    depends_on("iowarp-cte -nocompile", when="~nocompile")
    depends_on("iowarp-cte +nocompile", when="+nocompile")
    depends_on("iowarp-cte@main", when="@main")
    depends_on("iowarp-cte@priv", when="@priv")
    depends_on("iowarp-cte@dev", when="@dev")
    
    depends_on('iowarp-cte+debug', when='+debug')
    depends_on('iowarp-cte+ares', when='+ares')
    depends_on('iowarp-cte+encrypt', when='+encrypt')
    depends_on('iowarp-cte+compress', when='+compress')
    depends_on('iowarp-cte+python', when='+python')

    # Add iowarp-cae dependencies
    depends_on("iowarp-cae")
    depends_on("iowarp-cae -nocompile", when="~nocompile")
    depends_on("iowarp-cae +nocompile", when="+nocompile")
    depends_on("iowarp-cae@main", when="@main")
    depends_on("iowarp-cae@priv", when="@priv")
    depends_on("iowarp-cae@dev", when="@dev")
    
    depends_on('iowarp-cae+debug', when='+debug')
    depends_on('iowarp-cae+posix', when='+posix')
    depends_on('iowarp-cae+mpiio', when='+mpiio')
    depends_on('iowarp-cae+stdio', when='+stdio')
    depends_on('iowarp-cae+vfd', when='+vfd')
    depends_on('iowarp-cae+mpich', when='+mpich')
    depends_on('iowarp-cae+openmpi', when='+openmpi')

    depends_on('py-ppi-jarvis-cd', when='+ppi', type=('build', 'run'))
    depends_on('py-ppi-scspkg', when='+ppi', type=('build', 'run'))
    depends_on('ppi-chi-nettest', when='+ppi', type=('build', 'run'))
    depends_on('py-iowarp-runtime-util', type=('build', 'run'))
    depends_on('iowarp-base')

    # GPU variants
    variant("cuda", default=False, description="Enable CUDA support for iowarp")
    variant("rocm", default=False, description="Enable ROCm support for iowarp")
    depends_on("iowarp-cte+cuda", when="+cuda")
    depends_on("iowarp-cte+rocm", when="+rocm")
    depends_on("iowarp-cae+cuda", when="+cuda")
    depends_on("iowarp-cae+rocm", when="+rocm")
