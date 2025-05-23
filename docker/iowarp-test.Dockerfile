FROM iowarp/iowarp-user:latest
LABEL maintainer="llogan@hawk.iit.edu"
LABEL version="0.0"
LABEL description="IOWarp Docker image with CI"

# Disable prompt during packages installation.
ARG DEBIAN_FRONTEND=noninteractive

# Install iowarp package from GitHub main repository.
RUN . "${SPACK_DIR}/share/spack/setup-env.sh" && \
    spack load iowarp && \
    jarvis env build hermes && \
    jarvis ppl index copy jarvis_hermes.hermes.test_hermes && \
    jarvis ppl load yaml test_hermes.yaml && \
    jarvis ppl print && \
    cat $(jarvis path +shared)/hostfile

RUN ipcs -lm | grep "max seg size" | awk '{print $5}'

# Install iowarp package from GitHub main repository.
RUN . "${SPACK_DIR}/share/spack/setup-env.sh" && \
    spack load iowarp && \
    jarvis ppl run