# docker-autossh

## Build

```bash


. /usr/local/etc/sejnub-credentials.env

HB_ELKHOST_DEFAULT_USER=hebunjes
HB_ELKHOST_PRIV_KEY=klaus

echo "SEJNUB_ELK_SSH_PRIV_KEY=$SEJNUB_ELK_SSH_USER_PRIV_KEY"
echo "SEJNUB_ELK_SSH_USER=$SEJNUB_ELK_SSH_USER"

cd ~;
rm -rf docker-autossh;

cd ~;
git clone https://github.com/sejnub/docker-autossh.git;

cd ~/docker-autossh

docker build \
--build-arg HOST_USER=$HB_ELKHOST_DEFAULT_USER \
--build-arg HOST_PASS=$HB_ELKHOST_DEFAULT_PASS \
--build-arg HOST_PRIV_KEY=$HB_ELKHOST_PRIV_KEY         \
-t sejnub/autossh .


```

## Run

```bash

docker run sejnub/autossh

```

## Test

```bash

ssh localhost -p 33887 # Should work

ssh localhost -p 33888 # Should work

ssh localhost -p 33889 # Should not work

```
