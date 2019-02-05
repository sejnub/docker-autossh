#!/bin/bash




echo "#### build.sh has started."


# cd ~/docker-socat
# docker build                 \
#   -t sejnub/socat:latest     \
#   -t sejnub/socat:rpi-latest \
#   .


. /usr/local/etc/sejnub-credentials.env

cd ~/docker-autossh

# 4: rpi container -> elk host
HOST_FORWARDS=""
HOST_FORWARDS+="*:514:127.0.0.1:514"
HOST_FORWARDS+=","
HOST_FORWARDS+="*:515:127.0.0.1:515"
HOST_FORWARDS+=","
HOST_FORWARDS+="*:5000:127.0.0.1:5000"
HOST_FORWARDS+=","
HOST_FORWARDS+="*:5001:127.0.0.1:5001"
HOST_FORWARDS+=","
HOST_FORWARDS+="*:5601:127.0.0.1:5601"
HOST_FORWARDS+=","
HOST_FORWARDS+="*:9000:127.0.0.1:9000"
HOST_FORWARDS+=","
HOST_FORWARDS+="*:9001:127.0.0.1:9001"
HOST_FORWARDS+=","
HOST_FORWARDS+="*:9200:127.0.0.1:9200"

echo "HOST_FORWARDS = '$HOST_FORWARDS'"

# 5: elk host -> elk container
# docker-compose.yml
# "514:5514/udp"   syslog   -> logstash
# "515:5515"       syslog   -> logstash
# "5000:5000"      other    -> logstash
# "5001:5001/udp"  logspout -> logstash
# "5601:5601"      kibana
# "9001:9000"      cerebro
# "9200:9200"      data     -> elasticsearch


docker build                                         \
--build-arg HOST_NAME="elk.bunjes.net"               \
--build-arg HOST_PORT=443                            \
--build-arg HOST_FORWARDS=$HOST_FORWARDS             \
--build-arg HOST_USER="$SEJNUB_ELK_SSH_USER"         \
--build-arg HOST_PRIV_KEY="$SEJNUB_ELK_SSH_PRIV_KEY" \
-t sejnub/autossh .


echo "#### build.sh has ended."
