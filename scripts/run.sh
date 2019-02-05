#!/bin/bash

echo "#### run.sh has started."


# 3: rpi host -> rpi container
docker rm -f autossh-elk-bunjes-net
docker run         \
  -d               \
  -p 514:514       \
  -p 515:515       \
  -p 5000:5000     \
  -p 5001:5001     \
  -p 5601:5601     \
  -p 9001:9001     \
  -p 9002:9000     \
  -p 9200:9200     \
  --restart always \
  --name autossh-elk-bunjes-net sejnub/autossh


echo "#### run.sh has ended."
