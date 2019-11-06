## -*- docker-image-name: "test_images_r_stuff_optparse:0.0.1" -*-

FROM rocker/r-ver:3.6.1 as builder

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/optparse
ARG setup_env=${prefix}/setup_env

WORKDIR ${prefix}

SHELL ["/bin/bash", "-c"]

RUN install2.r --libloc=${prefix} --ncpus=${ncpus} optparse

FROM debian:buster-slim

ARG prefix=/opt/optparse
ARG setup_env=${prefix}/setup_env

COPY --from=builder ${prefix} ${prefix}

COPY setup_env ${setup_env}

# RUN bash ${setup_env}

WORKDIR ${prefix}
