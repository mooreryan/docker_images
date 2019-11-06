FROM base_images_clustalo:1.2.4-small as CLUSTALO

FROM debian:buster

COPY --from=CLUSTALO /opt/clustalo /opt/clustalo

RUN sh /opt/clustalo/setup_env

WORKDIR /root
