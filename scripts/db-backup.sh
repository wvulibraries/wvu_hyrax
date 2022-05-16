#!/bin/sh

# Author : Tracy A. McCormick
# WVU Libraries
# Date : 03/11/2022
# Updated : 05/16/2022
# Purpose : This script is used to export hyrax development database 
echo "Backing Up Hyrax Dev Database"
docker exec -t hyrax_db pg_dumpall -U postgres > ./scripts/postgres-db-dump/wvu-hyrax_`date +%d-%m-%Y"_"%H_%M_%S`.sql