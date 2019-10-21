FROM buildpack-deps:buster

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/rya_c
ARG setup_env=${prefix}/setup_env

RUN apt-get update && apt-get install -y cmake

WORKDIR ${downloads}/rya_c

RUN \curl -L 'https://github.com/mooreryan/rya_c/archive/v0.2.3.tar.gz' | \
    tar xz

WORKDIR rya_c-0.2.3/build

RUN cmake -DCMAKE_INSTALL_PREFIX=${prefix} .. && \
    make -j${ncpus} && \
    make install

WORKDIR ${home}
RUN rm -r ${downloads}

RUN printf "ln -sf ${prefix}/lib/* /usr/lib" > \
           ${setup_env} && \
    printf "ln -sf ${prefix}/include/* /usr/include" >> \
           ${setup_env}

# Setup the env in case you want to use this image directly.
RUN bash ${setup_env}
