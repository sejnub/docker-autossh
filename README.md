# docker-autossh

## Build

```bash

HB_ELKHOST_DEFAULT_USER=!!!
HB_ELKHOST_DEFAULT_PASS=!!!
HB_ELKHOST_PRIV_KEY=klaus


cd ~;
rm -rf docker-autossh;

cd ~;
git clone https://github.com/sejnub/docker-autossh.git;

cd ~/docker-autossh

docker build \
--build-arg HOST_DEFAULT_USER=$HB_ELKHOST_DEFAULT_USER \
--build-arg HOST_DEFAULT_PASS=$HB_ELKHOST_DEFAULT_PASS \
--build-arg HOST_PRIV_KEY=$HB_ELKHOST_PRIV_KEY         \
-t sejnub/autossh .

```

## Run

docker run sejnub/autossh

## Test

ssh localhost -p 33887 # Should work

ssh localhost -p 33888 # Should work

ssh localhost -p 33889 # Should not work