FROM base_images_rya_c:0.2.3

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/sample_seqs
ARG setup_env=${prefix}/setup_env

WORKDIR ${downloads}/sample_seqs

RUN \curl -L 'https://github.com/mooreryan/sample_seqs/archive/v0.1.5.tar.gz' | \
    tar xz

WORKDIR sample_seqs-0.1.5/build

RUN cmake -DCMAKE_PREFIX_PATH=/opt/rya_c \
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
