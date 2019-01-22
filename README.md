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

docker build \
--build-arg HOST_NAME="elk.bunjes.net"
--build-arg HOST_PORT=443
--build-arg HOST_FORWARDS="*:5601:127.0.0.1:5601,*:9001:0.0.0.0:9001"
--build-arg HOST_USER="$SEJNUB_ELK_SSH_USER"         \
--build-arg HOST_PRIV_KEY="$SEJNUB_ELK_SSH_PRIV_KEY" \
-t sejnub/autossh .


```

## Run

```bash

docker rm -f autossh
docker run -p 5601:5601 -p 9001:9001 --name autossh-elk-bunjes-net sejnub/autossh


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
