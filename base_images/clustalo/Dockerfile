FROM buildpack-deps:buster

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG ncpus=4
ARG prefix=/opt/clustalo
ARG setup_env=${prefix}/setup_env

ARG app_version="1.2.4"

WORKDIR ${prefix}/bin

RUN \curl http://www.clustal.org/omega/clustalo-${app_version}-Ubuntu-x86_64 > \
          clustalo

RUN chmod 755 clustalo

RUN printf "ln -sf ${prefix}/bin/* /usr/bin\n" > \
           ${prefix}/setup_env

WORKDIR ${home}

# Setup the env in case you want to use this image directly.
RUN bash ${setup_env}
