## -*- docker-image-name: "delete_me:0.0.1" -*-

FROM r_packages_optparse:rocker-verse-3.6.1 AS builder-optparse
FROM r_packages_vegan:rocker-verse-3.6.1 AS builder-vegan
FROM r_packages_mass:rocker-verse-3.6.1 AS builder-mass

FROM rocker/verse:3.6.1

LABEL maintainer="moorer@udel.edu"

ARG home=/root

COPY --from=builder-optparse /opt/optparse /opt/optparse
COPY --from=builder-vegan /opt/vegan /opt/vegan
COPY --from=builder-mass /opt/MASS /opt/MASS

RUN for f in /opt/*/setup_env; do bash "$f"; done

WORKDIR ${home}
