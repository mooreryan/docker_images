## -*- docker-image-name: "base_images_rya_c:0.2.3" -*-

FROM buildpack-deps:buster AS builder

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/rya_c
ARG setup_env=${prefix}/setup_env

ENV app_version 0.2.3

RUN apt-get update && apt-get install -y cmake

WORKDIR ${downloads}/rya_c

RUN \curl -sSL https://github.com/mooreryan/rya_c/archive/v${app_version}.tar.gz | \
    tar xz

WORKDIR rya_c-${app_version}/build

RUN cmake -DCMAKE_INSTALL_PREFIX=${prefix} .. && \
    make -j${ncpus} && \
    make install

WORKDIR ${home}
RUN rm -r ${downloads}

# Ideally this would be in /usr/local/.
RUN printf "ln -sf ${prefix}/lib/* /usr/lib\n" > \
           ${setup_env} && \
    printf "ln -sf ${prefix}/include/* /usr/include\n" >> \
           ${setup_env}

FROM debian:buster-slim

ARG prefix=/opt/rya_c
ARG setup_env=${prefix}/setup_env

COPY --from=builder ${prefix} ${prefix}

WORKDIR ${prefix}

# Setup the env in case you want to use this image directly.
RUN bash ${setup_env}
