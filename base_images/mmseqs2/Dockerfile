## -*- docker-image-name: "base_images_mmseqs2:5ae5503" -*-

FROM buildpack-deps:buster AS builder

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/MMseqs2
ARG setup_env=${prefix}/setup_env

RUN apt-get update && apt-get install -y cmake

WORKDIR /opt

RUN git clone -n https://github.com/soedinglab/MMseqs2.git

WORKDIR ${prefix}

RUN git checkout 5ae5503a923ec4338464d09cc1ff4bc3680727da

WORKDIR MMseqs2/build

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
ARG prefix=/opt/MMseqs2
ARG setup_env=${prefix}/setup_env

RUN apt-get update && apt-get install -y \
      gawk bash grep libstdc++6 libgomp1 zlib1g libbz2-1.0 \
      && rm -rf /var/lib/apt/lists/*

WORKDIR ${prefix}/bin

COPY --from=builder ${prefix}/build_sse/src/mmseqs ${prefix}/bin/mmseqs_sse42
COPY --from=builder ${prefix}/build_avx/src/mmseqs ${prefix}/bin/mmseqs_avx2
COPY --from=builder ${prefix}/setup_env ${prefix}/setup_env

RUN echo '#!/bin/bash\n\
if $(grep -q -E "^flags.+avx2" /proc/cpuinfo); then\n\
    exec /opt/MMseqs2/bin/mmseqs_avx2 "$@"\n\
else\n\
    exec /opt/MMseqs2/bin/mmseqs_sse42 "$@"\n\
fi'\
    >> ${prefix}/bin/mmseqs && \
    chmod 755 ${prefix}/bin/mmseqs

RUN bash ${setup_env}

WORKDIR ${prefix}
