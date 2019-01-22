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


# 4: elk host -> elk container
# docker-compose.yml
# "514:5514/udp"   syslog   -> logstash
# "515:5515"       syslog   -> logstash
# "5000:5000"      other    -> logstash
# "5001:5001/udp"  logspout -> logstash
# "5601:5601"      kibana
# "9001:9000"      cerebro
# "9200:9200"      data     -> elasticsearch


# 3: rpi container -> elk host
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

echo "HOST_FORWARDS = '$HOST_FORWARDS'"

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

# 2: rpi host -> rpi container
docker rm -f autossh-elk-bunjes-net
docker run         \
  -p 514:514       \
  -p 515:515       \
  -p 5000:5000     \
  -p 5601:5601     \
  -p 9001:9001     \
  -p 9002:9000     \
  -p 9200:9200     \
  --restart always \
  --name autossh-elk-bunjes-net sejnub/autossh


```

# 1: rpi host -> rpi host
#############################
# TODO: UDP to TCP bridging #
#############################
#
# - https://github.com/Konstanty/udp-tcp-bridge
# - https://unix.stackexchange.com/questions/267118/create-udp-to-tcp-bridge-with-socat-netcat-to-relay-control-commands-for-vlc-med
#   - sudo nc -v -u -l -p 514 | nc -v 127.0.0.1 515
#
# - wait for first command to return (when multiple active udp tcp brdges)
#   - https://docs.docker.com/config/containers/multi-service_container/


## Test


```bash

ssh -N -L *:5601:127.0.0.1:5601 -L *:9001:0.0.0.0:9001 -l hebunjes elk.bunjes.net



# Fake syslog

# UDP
echo "<14>Test11 UDP sejnub" | nc -v -u -w 0 localhost 514

# TCP
echo "<14>Test12 TCP sejnub" | nc -v -u -w 0 localhost 515



```



```bash

ssh localhost -p 33887 # Should work

ssh localhost -p 33888 # Should work

ssh localhost -p 33889 # Should not work

```
