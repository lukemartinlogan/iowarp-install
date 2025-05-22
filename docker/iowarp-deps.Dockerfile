FROM iowarp/iowarp-deps-spack:latest
LABEL maintainer="llogan@hawk.iit.edu"
LABEL version="0.0"
LABEL description="IOWarp dependencies Docker image"

# Disable prompt during packages installation.
ARG DEBIAN_FRONTEND=noninteractive

# Uninstall iowarp.
RUN . "${SPACK_DIR}/share/spack/setup-env.sh" && \
    spack uninstall -y --all --dependents iowarp-base

# Install iowarp.
RUN . "${SPACK_DIR}/share/spack/setup-env.sh" && \
    spack install -y iowarp@main+vfd+mpiio+compress+encrypt+nocompile

# Setup modules.
RUN . "${SPACK_DIR}/share/spack/setup-env.sh" && \
    spack load iowarp && \
    echo "source ~/.scspkg/bin/scsmod.sh" >> ${HOME}/.bashrc && \
    scspkg init bash

# Setup jarvis.
RUN . "${SPACK_DIR}/share/spack/setup-env.sh" && \
    spack load iowarp && \
    jarvis bootstrap from local && \
    jarvis rg build
