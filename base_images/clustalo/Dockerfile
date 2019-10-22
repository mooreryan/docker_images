FROM buildpack-deps:buster AS builder

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/clustalo
ARG setup_env=${prefix}/setup_env

ENV app_version 1.2.4

WORKDIR ${prefix}/bin

RUN \curl http://www.clustal.org/omega/clustalo-${app_version}-Ubuntu-x86_64 > \
          clustalo && \
    chmod 755 clustalo

RUN printf "ln -sf ${prefix}/bin/* /usr/local/bin\n" > \
           ${prefix}/setup_env

FROM debian:buster-slim

ARG prefix=/opt/clustalo
ARG setup_env=${prefix}/setup_env

COPY --from=builder ${prefix} ${prefix}

# Setup the env in case you want to use this image directly.
RUN bash ${setup_env}

WORKDIR ${prefix}
