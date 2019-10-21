FROM buildpack-deps:buster

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/MMseqs2
ARG setup_env=${prefix}/setup_env

WORKDIR ${downloads}

RUN apt-get update && apt-get install -y cmake

RUN git clone https://github.com/soedinglab/MMseqs2.git

WORKDIR MMseqs2/build

RUN cmake -DCMAKE_BUILD_TYPE=RELEASE \
          -DCMAKE_INSTALL_PREFIX=${prefix} \
          .. && \
    make -j${ncpus} && \
    make install

WORKDIR ${home}

RUN rm -r ${downloads}

RUN printf "ln -sf ${prefix}/bin/* /usr/bin\n" > \
           ${prefix}/setup_env

# Setup the env in case you want to use this image directly.
RUN bash ${setup_env}
