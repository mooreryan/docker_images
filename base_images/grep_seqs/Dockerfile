FROM buildpack-deps:buster

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

RUN printf "ln -sf ${prefix}/bin/* /usr/bin\n" > \
           ${prefix}/setup_env

# Setup the env in case you want to use this image directly.
RUN bash ${setup_env}
