## -*- docker-image-name: "projects_pasv_homology_test:1.4" -*-

FROM mooreryan/base_images_bbmap:38.69 AS bbmap-builder
FROM mooreryan/base_images_seqkit:0.11.0 AS seqkit-builder
FROM mooreryan/base_images_cli_apps:0.3.1 AS cli_apps-builder
FROM mooreryan/base_images_grep_seqs:4a729a2-2 AS grep_seqs-builder
FROM mooreryan/base_images_mmseqs2:ebb16f3 AS mmseqs2-builder
FROM mooreryan/base_images_shell_helpers:1.0 AS shell_helpers-builder


# Also includes rya_c:0.2.3
FROM mooreryan/base_images_sample_seqs:0.1.5 AS sample_seqs-builder

# Also includes the clustalo and mafft binaries.
FROM mooreryan/pasv:1.2.1 AS pasv-builder

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/pasv
ARG setup_env=${prefix}/setup_env

ENV project_version 1.0

SHELL ["/bin/bash", "-c"]

COPY --from=bbmap-builder /opt/bbmap /opt/bbmap

# Set up JRE
COPY --from=bbmap-builder /usr/local/openjdk-8 /usr/local/openjdk-8
ENV JAVA_HOME=/usr/local/openjdk-8
ENV JAVA_BASE_URL=https://github.com/AdoptOpenJDK/openjdk8-upstream-binaries/releases/download/jdk8u232-b09/OpenJDK8U-jre_
ENV JAVA_URL_VERSION=8u232b09
ENV JAVA_VERSION=8u232
ENV PATH=/usr/local/openjdk-8/bin:${PATH}

COPY --from=seqkit-builder /opt/seqkit /opt/seqkit

COPY --from=cli_apps-builder /opt/cli_apps /opt/cli_apps

COPY --from=grep_seqs-builder /opt/grep_seqs /opt/grep_seqs

COPY --from=mmseqs2-builder /opt/MMseqs2 /opt/MMseqs2
COPY --from=mmseqs2-builder /usr/lib/x86_64-linux-gnu/libgomp.so.1 \
                    /usr/lib/x86_64-linux-gnu/libgomp.so.1

COPY --from=sample_seqs-builder /opt/rya_c /opt/rya_c
COPY --from=sample_seqs-builder /opt/sample_seqs /opt/sample_seqs

COPY --from=shell_helpers-builder /opt/shell_helpers /opt/shell_helpers

# MMseqs2 needs libgomp.so.1
# RUN apt-get update && apt-get install -y

# Make sure cli_apps is set up properly.  Ideally we'd just merge the
# /usr/local/bundle from that image with the one in this one.
RUN cd /opt/cli_apps && \
    gem install bundler && \
    bundle install

RUN for f in /opt/*/setup_env; do bash "$f"; done

# Finally some Ruby gems needed for this analysis.

# Need make to install json.

RUN apt-get update && \
    apt-get install -y \
                    --no-install-recommends \
                    gcc \
                    make && \
    rm -r /var/lib/apt/lists/* && \
    gem install json \
                optimist \
                parse_fasta \
                rya && \
    apt-get remove -y gcc make

RUN apt-get update && apt-get install -y --no-install-recommends tree

WORKDIR ${home}
