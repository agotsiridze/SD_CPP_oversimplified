ARG CUDA_VERSION=13.3.0
ARG PORT=8080

FROM nvidia/cuda:${CUDA_VERSION}-devel-ubuntu22.04 AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    git cmake build-essential curl ca-certificates gnupg \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && npm install -g pnpm \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
RUN git config --global http.postBuffer 1048576000 \
    && git config --global http.version HTTP/1.1 \
    && git clone --recursive --depth 1 https://github.com/leejet/stable-diffusion.cpp.git .
RUN cmake -B build -DSD_CUDA=ON -DSD_SERVER_BUILD_FRONTEND=ON -DCMAKE_BUILD_TYPE=Release \
    && cmake --build build --config Release -j$(nproc)
RUN test -f /src/build/bin/sd-server || (echo "SERVER BUILD FAILED - binary not found" && exit 1)
RUN test -f /src/build/bin/sd-cli || (echo "CLI BUILD FAILED - binary not found" && exit 1)
RUN /src/build/bin/sd-server --help 2>&1 | grep -i cuda || echo "WARNING: CUDA may not be enabled"


FROM nvidia/cuda:${CUDA_VERSION}-runtime-ubuntu22.04
ARG PORT

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 \
    ca-certificates \
    aria2 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY --from=builder /src/build/bin/sd-server /src/sd-server
COPY --from=builder /src/build/bin/sd-cli /src/sd-cli
WORKDIR /workplace

EXPOSE ${PORT}

CMD ["tail", "-f", "/dev/null"]
