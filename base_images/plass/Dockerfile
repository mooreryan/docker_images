## -*- docker-image-name: "base_images_plass:c4f7b239" -*-

# Based on the following Dockerfile: https://github.com/soedinglab/plass/blob/c4f7b2392f26c71e8c596466a3e620297c748fa7/Dockerfile

FROM buildpack-deps:buster AS builder

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/plass
ARG setup_env=${prefix}/setup_env

RUN apt-get update && apt-get install -y cmake

WORKDIR /opt

RUN git clone -n https://github.com/soedinglab/plass.git

WORKDIR ${prefix}

RUN git checkout c4f7b2392f26c71e8c596466a3e620297c748fa7
RUN git submodule update --init

WORKDIR ${prefix}/build_sse
RUN cmake -DHAVE_MPI=0 -DHAVE_TESTS=0 -DHAVE_SSE4_1=1 -DCMAKE_BUILD_TYPE=Release ..
RUN make -j $(nproc --all)

WORKDIR ${prefix}/build_avx
RUN cmake -DHAVE_MPI=0 -DHAVE_TESTS=0 -DHAVE_AVX2=1 -DCMAKE_BUILD_TYPE=Release ..
RUN make -j $(nproc --all)

RUN printf "ln -sf ${prefix}/bin/* /usr/local/bin\n" > \
    ${prefix}/setup_env

FROM debian:buster-slim

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/plass
ARG setup_env=${prefix}/setup_env

RUN apt-get update && apt-get install -y \
      gawk bash grep libstdc++6 libgomp1 zlib1g libbz2-1.0 \
      && rm -rf /var/lib/apt/lists/*

WORKDIR ${prefix}/bin

COPY --from=builder ${prefix}/build_sse/src/plass ${prefix}/bin/plass_sse42
COPY --from=builder ${prefix}/build_avx/src/plass ${prefix}/bin/plass_avx2
COPY --from=builder ${prefix}/setup_env ${prefix}/setup_env

RUN echo '#!/bin/bash\n\
if $(grep -q -E "^flags.+avx2" /proc/cpuinfo); then\n\
    exec /opt/plass/bin/plass_avx2 "$@"\n\
else\n\
    exec /opt/plass/bin/plass_sse42 "$@"\n\
fi'\
    >> ${prefix}/bin/plass && \
    chmod 755 ${prefix}/bin/plass

RUN bash ${setup_env}

WORKDIR ${prefix}
