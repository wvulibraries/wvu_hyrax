#!/bin/sh

# Author : Tracy A. McCormick
# WVU Libraries
# Date : 06/03/2022
# Purpose : This script is used to export mfcs development database 
echo "Backing Up Hyrax Dev Database"
docker exec -t hyrax_db pg_dumpall -U postgres > ./scripts/postgres-db-dump/wvu_hyrax_`date +%d-%m-%Y"_"%H_%M_%S`.sql
# docker exec -t hyrax_db pg_dump -U postgres --blobs > ./postgres-db-dump/wvu_hyrax_`date +%d-%m-%Y"_"%H_%M_%S`.dump mfcs_dev