FROM base_images_mafft:7.429 as MAFFT
FROM base_images_clustalo:1.2.4 as CLUSTALO

FROM base_images_ruby:2.6.5

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/pasv
ARG setup_env=${prefix}/setup_env

ARG app_version="1.2.0"

COPY --from=MAFFT /opt/mafft /opt/mafft
COPY --from=CLUSTALO /opt/clustalo /opt/clustalo

WORKDIR ${downloads}

RUN \curl -L https://github.com/mooreryan/pasv/archive/v${app_version}.tar.gz | \
    tar xz

WORKDIR pasv-${app_version}

# Many of the apps are ruby apps.  Make sure they're executable.
RUN chmod 755 pasv

RUN gem install bundler && bundle install

WORKDIR ${downloads}

RUN mv pasv-${app_version} ${prefix}

WORKDIR ${home}

RUN rm -r ${downloads}

RUN printf "ln -sf ${prefix}/pasv /usr/bin\n" > \
           ${prefix}/setup_env

# Make sure all the setups are done.
RUN for f in `ls /opt/*/setup_env`; do bash $f; done


# Setup the env in case you want to use this image directly.
RUN bash ${setup_env}
