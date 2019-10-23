## -*- docker-image-name: "base_images_mmseqs2:ebb16f3" -*-

FROM buildpack-deps:buster AS builder

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/MMseqs2
ARG setup_env=${prefix}/setup_env

WORKDIR ${downloads}

RUN apt-get update && apt-get install -y cmake

RUN git clone https://github.com/soedinglab/MMseqs2.git

WORKDIR MMseqs2/build

RUN cmake -DCMAKE_BUILD_TYPE=RELEASE \
          -DCMAKE_INSTALL_PREFIX=${prefix} \
          .. && \
    make -j${ncpus} && \
    make install

WORKDIR ${home}

RUN rm -r ${downloads}

RUN printf "ln -sf ${prefix}/bin/* /usr/local/bin\n" > \
           ${prefix}/setup_env

RUN ls /lib/x86_64-linux-gnu
RUN ldd ${prefix}/bin/mmseqs

FROM debian:buster

ARG prefix=/opt/MMseqs2
ARG setup_env=${prefix}/setup_env

COPY --from=builder ${prefix} ${prefix}
# debian:buster doesn't have this lib.
COPY --from=builder /usr/lib/x86_64-linux-gnu/libgomp.so.1 \
                    /usr/lib/x86_64-linux-gnu/libgomp.so.1

# Setup the env in case you want to use this image directly.
RUN bash ${setup_env}

WORKDIR ${prefix}
