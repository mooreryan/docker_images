## -*- docker-image-name: "base_images_shell_helpers:1.0" -*-

FROM debian:buster-slim

ARG prefix=/opt/shell_helpers
ARG setup_env=${prefix}/setup_env

WORKDIR ${prefix}

COPY shell_helpers .

RUN apt-get update && apt-get install -y tree

RUN printf "cat ${prefix}/shell_helpers >> ~/.bashrc\n" > \
           ${setup_env}
