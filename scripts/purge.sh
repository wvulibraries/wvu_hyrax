# delete all saved docker volumes
docker volume rm $(docker volume ls -q)
# delete data folder contents
rm -rf ./data/*
# delete all logs
rm -rf ./log/*.log
