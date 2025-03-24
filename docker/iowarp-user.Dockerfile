# Install ubuntu 22.04
FROM iowarp/iowarp-deps:latest
LABEL maintainer="llogan@hawk.iit.edu"
LABEL version="0.0"
LABEL description="Hermes Docker image with CI"

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Install hermes
RUN . /module_load.sh && \
    . "${SPACK_DIR}/share/spack/setup-env.sh" && \
    spack uninstall -y iowarp && \
    spack install -y iowarp@main +vfd +mpiio
