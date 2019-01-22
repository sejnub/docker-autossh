# docker-autossh

## Build

```bash

################################################################################
################################################################################
################################################################################
################################################################################

. /usr/local/etc/sejnub-credentials.env

cd ~;
rm -rf docker-autossh;

cd ~;
git clone https://github.com/sejnub/docker-autossh.git;

cd ~/docker-autossh

# TODO: https://github.com/Konstanty/udp-tcp-bridge
# https://unix.stackexchange.com/questions/267118/create-udp-to-tcp-bridge-with-socat-netcat-to-relay-control-commands-for-vlc-med
# nc -v -u -l -p 3333 | nc -v 127.0.0.1 50000

# wait for first command to return (when multiple active udp tcp brdges)
# https://docs.docker.com/config/containers/multi-service_container/


# "9200:9200"      data     -> elasticsearch
# "5000:5000"      other    -> logstash
# "5001:5001/udp"  logspout -> logstash
# "514:5514/udp"   syslog   -> logstash
# "5601:5601"      kibana
# "9001:9000"      cerebro

HOST_FORWARDS="" +
"*:5601:127.0.0.1:5601," +
"*:9000:0.0.0.0:9000,"   +
"*:9001:0.0.0.0:9001"    +
""

docker build                                         \
--build-arg HOST_NAME="elk.bunjes.net"               \
--build-arg HOST_PORT=443                            \
--build-arg HOST_FORWARDS=$HOST_FORWARDS             \
--build-arg HOST_USER="$SEJNUB_ELK_SSH_USER"         \
--build-arg HOST_PRIV_KEY="$SEJNUB_ELK_SSH_PRIV_KEY" \
-t sejnub/autossh .


```

## Run

```bash

docker rm -f autossh
docker run         \
  -p 5601:5601     \
  -p 9001:9001     \
  -p 9002:9000     \
  -p 9001:9001     \
  --restart always \
  --name autossh-elk-bunjes-net sejnub/autossh


```

## Test


```bash

ssh -N -L *:5601:127.0.0.1:5601 -L *:9001:0.0.0.0:9001 -l hebunjes elk.bunjes.net


```



```bash

ssh localhost -p 33887 # Should work

ssh localhost -p 33888 # Should work

ssh localhost -p 33889 # Should not work

```
