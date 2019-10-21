FROM buildpack-deps:buster

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/mafft
ARG setup_env=${prefix}/setup_env

ARG app_version="7.429"

WORKDIR ${downloads}


RUN \curl https://mafft.cbrc.jp/alignment/software/mafft-7.429-without-extensions-src.tgz | \
    tar xz


WORKDIR mafft-${app_version}-without-extensions/core

# Need to adjust Makefile "by hand".
RUN sed -ibackup 's~PREFIX = /usr/local~PREFIX = /opt/mafft~' Makefile

RUN make -j${ncpus} && \
    make install

WORKDIR ${home}

RUN rm -r ${downloads}

RUN printf "ln -sf ${prefix}/bin/* /usr/bin\n" > \
           ${prefix}/setup_env

# Setup the env in case you want to use this image directly.
RUN bash ${setup_env}
