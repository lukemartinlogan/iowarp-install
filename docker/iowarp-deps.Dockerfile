# Install ubuntu latest
FROM iowarp/iowarp-base:latest
LABEL maintainer="llogan@hawk.iit.edu"
LABEL version="0.0"
LABEL description="IoWarp dependencies docker image"

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Install iowarp
RUN . /module_load.sh && \
    . "${SPACK_DIR}/share/spack/setup-env.sh" && \
    spack install iowarp@main+nocompile

# Setup modules
RUN . "${SPACK_DIR}/share/spack/setup-env.sh" && \
    spack load iowarp && \
    echo "module use $(scspkg module dir)" >> ${HOME}/.bashrc && \
    scspkg init

# Setup jarvis 
RUN . "${SPACK_DIR}/share/spack/setup-env.sh" && \
    spack load iowarp && \
    echo "module use $(scspkg module dir)" >> ${HOME}/.bashrc && \
    jarvis bootstrap from local

