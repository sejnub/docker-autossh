# docker-autossh

## Build

```bash

################################################################################
################################################################################
################################################################################
################################################################################

. /usr/local/etc/sejnub-credentials.env

echo "SEJNUB_ELK_SSH_USER=$SEJNUB_ELK_SSH_USER"
echo "SEJNUB_ELK_SSH_PRIV_KEY=$SEJNUB_ELK_SSH_PRIV_KEY"

cd ~;
rm -rf docker-autossh;

cd ~;
git clone https://github.com/sejnub/docker-autossh.git;

cd ~/docker-autossh

docker build \
--build-arg HOST_USER="$SEJNUB_ELK_SSH_USER"         \
--build-arg HOST_PRIV_KEY="$SEJNUB_ELK_SSH_PRIV_KEY" \
-t sejnub/autossh .


```

## Run

```bash

docker rm -f autossh
docker run --name autossh sejnub/autossh


```

## Test

```bash

ssh localhost -p 33887 # Should work

ssh localhost -p 33888 # Should work

ssh localhost -p 33889 # Should not work

```
