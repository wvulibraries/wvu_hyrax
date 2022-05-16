#!/bin/bash

# remove fedora data folder
rm -rf fedora 

# remove postgres data folder
rm -rf postgres

# remove solr data folder
rm -rf solr/data

# delete all logs
rm -rf ./hyrax/log/*.log
