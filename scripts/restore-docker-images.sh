#!/bin/sh

# Author : Tracy A. McCormick
# WVU Libraries
# Date : 03/11/2022
# Updated : 05/16/2022
# Purpose : This script is used to import docker images used by mfcs
# and quickly rebuild the development enviroment

echo "Loading Docker Images Used by WVU Hyrax"
echo "Loading Postgres 14 Alpine Image"
docker image load -i ./docker_images/postgres14-alpine.tar
# echo "Loading Redis Alpine Image"
# docker image load -i ./docker_images/redis-alpine.tar
# echo "Loading Elasticsearch 7.16.2 Image"
# docker image load -i ./docker_images/elasticsearch-7.16.2.tar

# need to adjust on how to properly load images for mfcs ruby
# echo "Loading mfcs-ruby_sidekiq Image"
# docker image load -i ./images/mfcs-ruby_mfcs_ruby.tar
# echo "Loading mfcs-ruby_sidekiq Image"
# docker image load -i ./images/mfcs-ruby_sidekiq.tar
# echo "Loading mfcs-ruby_webpacker Image"
# docker image load -i ./images/mfcs-ruby_webpacker.tar

# restore old mfcs image
echo "Loading mfcs Image"
docker image load -i ./docker_images/mfcs.tar

# # restore images used for hydra heads
echo "Loading samvera fedora Image"
docker image load -i ./images/samvera-fedora.tar
# # save mysql
# echo "Loading mysql Image"
# docker image load -i ./images/mysql.tar
# # save solr
echo "Loading solr Image"
docker image load -i ./images/solr.8.11.1.tar
