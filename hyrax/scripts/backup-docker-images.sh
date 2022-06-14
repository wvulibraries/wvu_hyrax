#!/bin/sh

# Author : Tracy A. McCormick
# WVU Libraries
# Date : 03/11/2022
# Updated : 04/16/2022
# Purpose : This script is used to export mfcs images and quickly rebuild the development enviroment

for img in $( docker docker_images --format '{{.Repository}}:{{.Tag}}' --filter "dangling=false" ) ; do
    base=${img#*/}
    docker save "$img" | gzip > "${base//:/__}".tar.gz
done
