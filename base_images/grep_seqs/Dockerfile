## -*- docker-image-name: "base_images_grep_seqs:4a729a2-2" -*-

FROM buildpack-deps:buster AS builder

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/grep_seqs
ARG setup_env=${prefix}/setup_env

WORKDIR ${downloads}

RUN git clone https://github.com/mooreryan/grep_seqs.git

WORKDIR grep_seqs

RUN mkdir -p ${prefix}/bin

RUN gcc grep_ids.c \
        vendor/*.c \
        -I./vendor \
        -lz \
        -Wall \
        -g \
        -O3 \
        -o ${prefix}/bin/grep_ids

RUN gcc anti_grep_ids.c \
        vendor/*.c \
        -I./vendor \
        -lz \
        -Wall \
        -g \
        -O3 \
        -o ${prefix}/bin/anti_grep_ids

WORKDIR ${home}

RUN rm -r ${downloads}

RUN printf "ln -sf ${prefix}/bin/* /usr/local/bin\n" > \
           ${prefix}/setup_env

FROM debian:buster

ARG prefix=/opt/grep_seqs
ARG setup_env=${prefix}/setup_env

COPY --from=builder ${prefix} ${prefix}

# Setup the env in case you want to use this image directly.
RUN bash ${setup_env}

WORKDIR ${prefix}
