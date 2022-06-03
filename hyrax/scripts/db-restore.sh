#!/bin/sh

# Author : Tracy A. McCormick
# WVU Libraries
# Date : 06/03/2022
# Purpose : This script is used to import mfcs development database 
# Run script from the scripts folder on host machine
echo "Restoring Hyrax Dev Database"
file=$(ls -t ./scripts/postgres-db-dump/*.sql | head -1)
cat $file | docker exec -i mfcs_db psql -U postgres