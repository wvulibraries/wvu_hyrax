#!/bin/bash
#sidekiqmon.sh
# https://cohost.org/Totooria/post/291762-sidekiq-healthchecks
checkSidekiq() {
  if [ $(bundle exec sidekiqmon processes | grep -Po '\d' | awk '{s+=$1} END {print s}') -gt 0 ]; then
    exit 0
  else
    exit 1
  fi
}

checkSidekiq