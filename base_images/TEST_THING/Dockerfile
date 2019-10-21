FROM base_images_rya_c:0.2.3 as RYA_C

FROM base_images_sample_seqs:0.1.5 as SAMPLE_SEQS

FROM base_images_ruby:2.6.5

COPY --from=RYA_C /opt/rya_c /opt/rya_c
COPY --from=SAMPLE_SEQS /opt/sample_seqs /opt/sample_seqs

RUN for f in `ls /opt/*/setup_env`; do bash $f; done

WORKDIR /root
