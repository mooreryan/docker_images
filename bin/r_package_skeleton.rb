#!/usr/bin/env ruby
Signal.trap("PIPE", "EXIT")

require "FileUtils"

package = ARGV[0]

abort "usage: #{__FILE__} package_name" unless ARGV.count == 1

setup_env = %Q{#!/bin/bash

# Only add to the Renviron if the dir has something in it.
if [ "$(ls -A /opt/#{package})" ]; then
    printf "\\n\\nR_LIBS_USER=\\"\\${R_LIBS_USER}\\":/opt/#{package}\\n\\n" >> \\
           /usr/local/lib/R/etc/Renviron
fi

}

dockerfile = %Q^## -*- docker-image-name: "r_packages_#{package}:rocker-verse-3.6.1" -*-

FROM rocker/verse:3.6.1 as builder

LABEL maintainer="moorer@udel.edu"

ARG home=/root
ARG downloads=${home}/downloads
ARG ncpus=4
ARG prefix=/opt/#{package}
ARG setup_env=${prefix}/setup_env

WORKDIR ${prefix}

SHELL ["/bin/bash", "-c"]

# If this is already installed, then prefix will be empty.
RUN install2.r --libloc=${prefix} --ncpus=${ncpus} --skipinstalled #{package}

FROM debian:buster-slim

ARG prefix=/opt/#{package}
ARG setup_env=${prefix}/setup_env

COPY --from=builder ${prefix} ${prefix}

COPY setup_env ${setup_env}

WORKDIR ${prefix}
^


dir = File.join __dir__, "..", "r_packages", package

FileUtils.mkdir_p dir

File.open(File.join(dir, "Dockerfile"), "w") do |f|
  f.puts dockerfile
end

File.open(File.join(dir, "setup_env"), "w") do |f|
  f.puts setup_env
end
