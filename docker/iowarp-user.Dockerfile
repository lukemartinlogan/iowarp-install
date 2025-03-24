# Install ubuntu 22.04
FROM iowarp/iowarp-deps:latest
LABEL maintainer="llogan@hawk.iit.edu"
LABEL version="0.0"
LABEL description="Hermes Docker image with CI"

# Install hermes
RUN . /module_load.sh && \
    . "${SPACK_DIR}/share/spack/setup-env.sh" && \
    spack uninstall iowarp \
    spack install iowarp@main +vfd +mpiio
