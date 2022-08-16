# remove folders
# rm -r ./postgresdata
# rm -r ./redis
# rm -r ./hyrax/tmp

# remove docker volumes
docker volume prune

# remove docker images
docker image prune

# remove log files
rm -rf ./hyrax/log/*.log
