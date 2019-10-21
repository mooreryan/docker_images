FROM buildpack-deps:buster

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/ruby
ARG setup_env=${prefix}/setup_env

ENV RUBY_MAJOR 2.6
ENV RUBY_VERSION 2.6.5

WORKDIR ${downloads}

RUN \curl https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR}/ruby-${RUBY_VERSION}.tar.gz | \
    tar xz

WORKDIR ruby-${RUBY_VERSION}

RUN ./configure --prefix=${prefix} && \
    make -j${ncpus} && \
    make install

WORKDIR ${home}

RUN rm -r ${downloads}

RUN printf "ln -sf ${prefix}/bin/* /usr/bin\n" > \
           ${prefix}/setup_env

# Setup the env in case you want to use this image directly.
RUN bash ${setup_env}
