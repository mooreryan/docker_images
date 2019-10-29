## -*- docker-image-name: "base_images_seqkit:0.11.0" -*-

FROM buildpack-deps:buster AS builder

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/seqkit
ARG setup_env=${prefix}/setup_env

ENV app_version 0.11.0

WORKDIR ${prefix}/bin

SHELL ["/bin/bash", "-c"]

RUN \curl -sSL https://github.com/shenwei356/seqkit/releases/download/v${app_version}/seqkit_linux_amd64.tar.gz | \
    tar xz && \
    chmod 755 seqkit

RUN printf "ln -sf ${prefix}/bin/* /usr/local/bin\n" > \
           ${setup_env}

FROM debian:buster-slim

ARG prefix=/opt/seqkit
ARG setup_env=${prefix}/setup_env

COPY --from=builder ${prefix} ${prefix}

RUN bash ${setup_env}

WORKDIR ${prefix}
