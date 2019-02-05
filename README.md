# docker-autossh

TODO: Reorganize this repo like docker-socat

## coldstart

```sh

cd ~
curl https://raw.githubusercontent.com/sejnub/docker-autossh/master/scripts/coldstart.sh | bash

```

## Chain of port translations

See <https://bitbucket.org/sejnub/setup/src/master/smarthome/ports.txt>

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
