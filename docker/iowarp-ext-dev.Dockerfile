FROM iowarp/iowarp-deps:latest
LABEL maintainer="llogan@hawk.iit.edu"
LABEL version="0.0"
LABEL description="IOWarp Docker image for External (non-core) Developers"

# Disable prompt during packages installation.
ARG DEBIAN_FRONTEND=noninteractive

# Install iowarp package from GitHub main branch.
RUN . "${SPACK_DIR}/share/spack/setup-env.sh" && \
    spack install -y iowarp@main +vfd +mpiio +compress +encrypt
