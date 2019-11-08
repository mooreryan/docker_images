## -*- docker-image-name: "base_images_fixpairs:0.1.0" -*-

FROM buildpack-deps:buster AS builder

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/FixPairs
ARG setup_env=${prefix}/setup_env

ENV app_version 0.1.0

WORKDIR ${prefix}/bin

SHELL ["/bin/bash", "-c"]

RUN \curl -sSL https://github.com/mooreryan/FixPairs/releases/download/v0.1.0/FixPairs-v0.1.0-Fedora23 > FixPairs && \
    chmod 755 FixPairs

RUN printf "ln -sf ${prefix}/bin/* /usr/local/bin\n" > \
           ${setup_env}

FROM debian:buster-slim

ARG prefix=/opt/FixPairs
ARG setup_env=${prefix}/setup_env

COPY --from=builder ${prefix} ${prefix}

RUN bash ${setup_env}

WORKDIR ${prefix}
