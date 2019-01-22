# docker-autossh


## Build

HB_ELKHOST_DEFAULT_USER=!!!
HB_ELKHOST_DEFAULT_PASS=!!!
cd ~;
rm -rf docker-autossh;

cd ~;
git clone https://github.com/sejnub/docker-autossh.git;

cd ~/docker-autossh;
docker build --build-arg HB_ELKHOST_DEFAULT_USER=$HB_ELKHOST_DEFAULT_USER --build-arg HB_ELKHOST_DEFAULT_PASS=$HB_ELKHOST_DEFAULT_PASS -t sejnub/autossh .
