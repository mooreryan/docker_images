#!/bin/bash

if [[ $# -ne 4 ]]; then
    >&2 echo "usage: run_server img_name img_tag mnt_dir password"
    exit 1
fi

img_name="$1"
img_tag="$2"
mnt_dir="$3"
password="$4"

date && time docker run \
             --rm \
             -p 8787:8787 \
             -v "${mnt_dir}":"${mnt_dir}" \
             -e ROOT=true \
             -e USER=ryan \
             -e PASSWORD="${password}" \
             "${img_name}":"${img_tag}"
