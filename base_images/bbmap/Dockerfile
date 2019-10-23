## -*- docker-image-name: "base_images_bbmap:38.69" -*-

FROM buildpack-deps:buster AS builder

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/bbmap
ARG setup_env=${prefix}/setup_env

ENV app_version 38.69

WORKDIR /opt

SHELL ["/bin/bash", "-c"]

RUN \curl -sSL https://sourceforge.net/projects/bbmap/files/BBMap_${app_version}.tar.gz/download | \
    tar xz && \
    mkdir -p stuff && \
    mv bbmap/* stuff && \
    mv stuff bbmap/bin

RUN printf "ln -sf ${prefix}/bin/* /usr/local/bin\n" > \
           ${prefix}/setup_env

FROM openjdk:8u232-jre-slim-buster

ARG prefix=/opt/bbmap
ARG setup_env=${prefix}/setup_env

COPY --from=builder ${prefix} ${prefix}

RUN bash ${setup_env}

WORKDIR ${prefix}
