#!/bin/bash

# set terminal 
export TERM=vt100

# start cron and update whenever 
# service cron start
# whenever --update-crontab

# remove PID and start the server
file="/home/hyrax/tmp/pids/server.pid"
if [ -f $file ] ; then
    rm $file
fi

# remove fits.log if it exists
file="/home/hyrax/fits.log"
if [ -f $file ] ; then
    rm $file
fi

# create fits.log if it doesn't exist
file="/home/hyrax/log/fits.log"
if [ ! -f $file ] ; then
    touch $file
fi

# symlink /home/hyrax/fits.log to /home/hyrax/log/fits.log
ln -s /home/hyrax/log/fits.log /home/hyrax/fits.log

bundle exec rails s -p 3000 -b '0.0.0.0'