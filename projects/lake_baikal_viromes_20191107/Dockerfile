## -*- docker-image-name: "projects_lake_baikal_viromes_20191107:1.1" -*-

FROM soedinglab/plass:latest AS plass-builder
FROM soedinglab/mmseqs2:latest AS mmseqs-builder

FROM mooreryan/base_images_prodigal:2.6.3 AS prodigal-builder
FROM mooreryan/base_images_seqkit:0.11.0 AS seqkit-builder

FROM mooreryan/base_images_ruby:2.6.5

# Install PLASS
COPY --from=plass-builder /usr/local/bin/plass_sse42 /usr/local/bin/plass_sse42
COPY --from=plass-builder /usr/local/bin/plass_avx2 /usr/local/bin/plass_avx2
COPY --from=plass-builder /usr/local/bin/plass /usr/local/bin/plass

# Insatll mmseqs2
COPY --from=mmseqs-builder /usr/local/bin/mmseqs_sse42 /usr/local/bin/mmseqs_sse42
COPY --from=mmseqs-builder /usr/local/bin/mmseqs_avx2 /usr/local/bin/mmseqs_avx2
COPY --from=mmseqs-builder /usr/local/bin/mmseqs /usr/local/bin/mmseqs

# Insatll prodigal for gene prediction
COPY --from=prodigal-builder /opt/prodigal /opt/prodigal

# Install seqkit for random sampling.
COPY --from=seqkit-builder /opt/seqkit /opt/seqkit

RUN chmod 755 /usr/local/bin/plass* /usr/local/bin/mmseqs*

# Make sure environment is setup!
RUN for f in /opt/*/setup_env; do bash "$f"; done

RUN apt-get update && apt-get install -y --no-install-recommends parallel

WORKDIR /home
