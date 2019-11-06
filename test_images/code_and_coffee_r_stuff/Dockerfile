## -*- docker-image-name: "code_and_coffee_r_stuff:1.0" -*-

# Need this to fit models
FROM mooreryan/r_packages_caret:rocker-verse-3.6.1 AS builder-caret

# Need this for 'lda'
FROM mooreryan/r_packages_mass:rocker-verse-3.6.1 AS builder-mass

# Need this for the wine data
FROM mooreryan/r_packages_rattle_data:rocker-verse-3.6.1 AS builder-rattle_data

# Need this for 'rf'
FROM mooreryan/r_packages_randomforest:rocker-verse-3.6.1 AS builder-randomforest


FROM rocker/verse:3.6.1

LABEL maintainer="moorer@udel.edu"

ARG home=/root

COPY --from=builder-mass /opt/MASS /opt/MASS
COPY --from=builder-caret /opt/caret /opt/caret
COPY --from=builder-randomforest /opt/randomForest /opt/randomForest
COPY --from=builder-rattle_data /opt/rattle_data /opt/rattle_data


RUN for f in /opt/*/setup_env; do bash "$f"; done

WORKDIR ${home}
