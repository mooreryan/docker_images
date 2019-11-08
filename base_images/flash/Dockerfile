## -*- docker-image-name: "base_images_flash:1.2.11" -*-

FROM buildpack-deps:buster AS builder

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/flash
ARG setup_env=${prefix}/setup_env

ENV app_version 1.2.11

WORKDIR ${prefix}/bin

SHELL ["/bin/bash", "-c"]

RUN wget http://ccb.jhu.edu/software/FLASH/FLASH-1.2.11-Linux-x86_64.tar.gz && \
    tar xzf FLASH-1.2.11-Linux-x86_64.tar.gz && \
    mv FLASH-1.2.11-Linux-x86_64/flash . && \
    rm -r FLASH-1.2.11-Linux-x86_64.tar.gz \
          FLASH-1.2.11-Linux-x86_64 && \
    chmod 755 ./flash

RUN printf "ln -sf ${prefix}/bin/* /usr/local/bin\n" > \
           ${setup_env}

FROM debian:buster-slim

ARG prefix=/opt/flash
ARG setup_env=${prefix}/setup_env

COPY --from=builder ${prefix} ${prefix}

RUN bash ${setup_env}

WORKDIR ${prefix}
