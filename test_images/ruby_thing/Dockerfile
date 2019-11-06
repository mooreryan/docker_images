FROM mooreryan/base_images_ruby:2.6.5 AS ruby

FROM debian:buster-slim

COPY --from=ruby /opt/ruby /opt/ruby

WORKDIR /root
