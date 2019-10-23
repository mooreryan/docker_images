## -*- docker-image-name: "base_images_sample_seqs:0.1.5" -*-

FROM base_images_rya_c:0.2.3 AS rya_c-builder

FROM buildpack-deps:buster AS sample_seqs-builder

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/sample_seqs
ARG setup_env=${prefix}/setup_env

ENV app_version 0.1.5

RUN apt-get update && apt-get install -y cmake

# Set up rya_c
COPY --from=rya_c-builder /opt/rya_c /opt/rya_c
RUN bash /opt/rya_c/setup_env

WORKDIR ${downloads}/sample_seqs

RUN \curl -sSL https://github.com/mooreryan/sample_seqs/archive/v${app_version}.tar.gz | \
    tar xz

WORKDIR sample_seqs-${app_version}/build

RUN cmake -DCMAKE_PREFIX_PATH=/opt/rya_c \
          -DCMAKE_INSTALL_PREFIX=${prefix} \
          .. && \
    make -j${ncpus} && \
    make install

WORKDIR ${home}

RUN rm -r ${downloads}

RUN printf "ln -sf ${prefix}/bin/* /usr/local/bin\n" > \
           ${prefix}/setup_env

FROM ruby:2.6.5-slim-buster

ARG prefix=/opt/sample_seqs

COPY --from=rya_c-builder /opt/rya_c /opt/rya_c
COPY --from=sample_seqs-builder ${prefix} ${prefix}

# Setup the env in case you want to use this image directly.
RUN for f in /opt/*/setup_env; do bash $f; done

WORKDIR ${prefix}
