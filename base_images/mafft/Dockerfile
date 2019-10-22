FROM buildpack-deps:buster AS builder

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/mafft
ARG setup_env=${prefix}/setup_env

ENV app_version 7.429

WORKDIR ${downloads}

RUN \curl https://mafft.cbrc.jp/alignment/software/mafft-${app_version}-without-extensions-src.tgz | \
    tar xz && \
    cd mafft-${app_version}-without-extensions/core && \
    sed -ibackup 's~PREFIX = /usr/local~PREFIX = /opt/mafft~' Makefile && \
    make -j${ncpus} && \
    make install && \
    cd ${home} && \
    rm -r ${downloads} && \
    printf "ln -sf ${prefix}/bin/* /usr/local/bin\n" > \
           ${prefix}/setup_env

FROM debian:buster-slim

ARG prefix=/opt/mafft
ARG setup_env=${prefix}/setup_env

COPY --from=builder ${prefix} ${prefix}

# Setup the env in case you want to use this image directly.
RUN bash ${setup_env}
