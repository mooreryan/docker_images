FROM ruby:2.6.5-buster AS ruby-builder

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/cli_apps
ARG setup_env=${prefix}/setup_env

ENV app_version 0.3.1

WORKDIR /opt

RUN \curl -L https://github.com/mooreryan/cli_apps/archive/v${app_version}.tar.gz | \
    tar xz && \
    mv cli_apps-${app_version} cli_apps && \
    cd ${prefix} && \
    make -j${ncpus} all && \
    chmod 755 ${prefix}/bin/*

RUN printf "ln -sf ${prefix}/bin/* /usr/local/bin\n" > \
    ${prefix}/setup_env

FROM ruby:2.6.5-slim-buster

ARG prefix=/opt/cli_apps
ARG setup_env=${prefix}/setup_env

COPY --from=ruby-builder ${prefix} ${prefix}

WORKDIR ${prefix}

# Install needed gems.
RUN gem install bundler && bundle install

# Setup the env in case you want to use this image directly.
RUN bash ${setup_env}
