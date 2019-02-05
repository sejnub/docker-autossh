# docker-autossh

TODO: Reorganize this repo like docker-socat

## coldstart

```sh

cd ~
curl https://raw.githubusercontent.com/sejnub/docker-autossh/master/scripts/coldstart.sh | bash

```

## Chain of port translations

### 1: rpi host UDP -> rpi host TCP

### 2: rpi host -> rpi container
docker rm -f autossh-elk-bunjes-net
docker run         \
  -d               \
  -p 514:514       \
  -p 515:515       \
  -p 5000:5000     \
  -p 5601:5601     \
  -p 9001:9001     \
  -p 9002:9000     \
  -p 9200:9200     \
  --restart always \
  --name autossh-elk-bunjes-net sejnub/autossh

### 3: rpi container -> elk host

HOST_FORWARDS=""
HOST_FORWARDS+="*:514:127.0.0.1:514"
HOST_FORWARDS+=","
HOST_FORWARDS+="*:515:127.0.0.1:515"
HOST_FORWARDS+=","
HOST_FORWARDS+="*:5000:127.0.0.1:5000"
HOST_FORWARDS+=","
HOST_FORWARDS+="*:5601:127.0.0.1:5601"
HOST_FORWARDS+=","
HOST_FORWARDS+="*:9000:127.0.0.1:9000"
HOST_FORWARDS+=","
HOST_FORWARDS+="*:9001:127.0.0.1:9001"
HOST_FORWARDS+=","
HOST_FORWARDS+="*:9200:127.0.0.1:9200"

### 4: elk host -> elk container

docker-compose.yml
"514:5514/udp"   syslog   -> logstash
"515:5515"       syslog   -> logstash
"5000:5000"      other    -> logstash
"5001:5001/udp"  logspout -> logstash
"5601:5601"      kibana
"9001:9000"      cerebro
"9200:9200"      data     -> elasticsearch

## doc

### Multiple processes in one container

Stop container if one of the processes has stopped. This might be a solution if I want multiple active udp tcp brdges.

- Exaple from docker
  - <https://docs.docker.com/config/containers/multi-service_container/>

- Example from some forum

```bash
#!/bin/bash
/usr/bin/stunnel4 /stunnel.conf &
/usr/local/bin/redis-server /etc/redis/redis.conf &
wait -n
kill %1 %2
echo "All process finished"
```
