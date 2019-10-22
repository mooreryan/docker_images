FROM mooreryan/base_images_ruby:2.6.5

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/cli_apps
ARG setup_env=${prefix}/setup_env

ARG app_version="0.3.1"

WORKDIR ${downloads}

RUN \curl -L https://github.com/mooreryan/cli_apps/archive/v${app_version}.tar.gz | \
    tar xz

WORKDIR cli_apps-${app_version}

# Many of the apps are ruby apps.  Make sure they're executable.
RUN chmod 755 bin/*

RUN gem install bundler && bundle install

# Some are C programs.  This will install them to ./bin
RUN make all

# Now move them to the correct bin dir.
RUN mkdir -p ${prefix}/bin && \
    mv ./bin/* ${prefix}/bin

WORKDIR ${home}

RUN rm -r ${downloads}

RUN printf "ln -sf ${prefix}/bin/* /usr/bin\n" > \
           ${prefix}/setup_env

# Setup the env in case you want to use this image directly.
RUN bash ${setup_env}
