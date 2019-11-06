## -*- docker-image-name: "r_packages_foreach:rocker-verse-3.6.1" -*-

FROM rocker/verse:3.6.1 as builder

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/foreach
ARG setup_env=${prefix}/setup_env

WORKDIR ${prefix}

SHELL ["/bin/bash", "-c"]

# If this is already installed, then prefix will be empty.
RUN install2.r --libloc=${prefix} --ncpus=${ncpus} --skipinstalled foreach

FROM debian:buster-slim

ARG prefix=/opt/foreach
ARG setup_env=${prefix}/setup_env

COPY --from=builder ${prefix} ${prefix}

COPY setup_env ${setup_env}

WORKDIR ${prefix}
