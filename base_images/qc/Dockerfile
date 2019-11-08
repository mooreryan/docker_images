## -*- docker-image-name: "base_images_qc:0.6.2" -*-

FROM mooreryan/base_images_bowtie:2.3.5.1 AS bowtie_builder
FROM mooreryan/base_images_fixpairs:0.1.0 AS fixpairs_builder
FROM mooreryan/base_images_flash:1.2.11 AS flash_builder

FROM mooreryan/base_images_ruby:2.6.5

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/qc
ARG setup_env=${prefix}/setup_env

ARG app_version="0.6.2"

COPY --from=bowtie_builder /opt/bowtie /opt/bowtie
COPY --from=fixpairs_builder /opt/FixPairs /opt/FixPairs
COPY --from=flash_builder /opt/flash /opt/flash

# Install OpenJDK Java JRE.
RUN apt-get update && apt-get install -y --no-install-suggests default-jre

WORKDIR ${prefix}

RUN \curl -L https://github.com/mooreryan/qc/archive/v${app_version}.tar.gz | \
    tar xz && \
    cd qc-${app_version} && \
    chmod 755 qc*rb && \
    bundle install && \
    cd ${prefix} && \
    mv qc-${app_version}/* . && \
    rm -r qc-${app_version}

RUN printf "ln -sf ${prefix}/qc*rb /usr/local/bin\n" > \
           ${prefix}/setup_env

# Make sure all the setups are done.
RUN for f in `ls /opt/*/setup_env`; do bash $f; done
