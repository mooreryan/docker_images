## -*- docker-image-name: "base_images_bowtie:2.3.5.1" -*-

FROM buildpack-deps:buster AS builder

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/bowtie
ARG setup_env=${prefix}/setup_env

ENV app_version 2.3.5.1

WORKDIR ${prefix}

SHELL ["/bin/bash", "-c"]

RUN wget https://github.com/BenLangmead/bowtie2/releases/download/v2.3.5.1/bowtie2-2.3.5.1-linux-x86_64.zip && \
    unzip bowtie2-2.3.5.1-linux-x86_64.zip && \
    rm bowtie2-2.3.5.1-linux-x86_64.zip && \
    mkdir -p ${prefix}/bin && \
    mv bowtie2-2.3.5.1-linux-x86_64/bowtie* ${prefix}/bin && \
    rm -r bowtie2-2.3.5.1-linux-x86_64

RUN printf "ln -sf ${prefix}/bin/* /usr/local/bin\n" > \
           ${setup_env}

RUN bash ${setup_env}

WORKDIR ${prefix}
