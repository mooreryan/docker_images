## -*- docker-image-name: "base_images_prodigal:2.6.3" -*-

FROM buildpack-deps:buster AS builder

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/prodigal
ARG setup_env=${prefix}/setup_env

ENV app_version 2.6.3

WORKDIR ${prefix}/bin

SHELL ["/bin/bash", "-c"]

RUN \curl -sSL https://github.com/hyattpd/Prodigal/releases/download/v2.6.3/prodigal.linux > prodigal && \
    chmod 755 prodigal

RUN printf "ln -sf ${prefix}/bin/* /usr/local/bin\n" > \
           ${setup_env}

FROM debian:buster-slim

ARG prefix=/opt/prodigal
ARG setup_env=${prefix}/setup_env

COPY --from=builder ${prefix} ${prefix}

RUN bash ${setup_env}

WORKDIR ${prefix}
