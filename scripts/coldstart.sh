#!/bin/bash

export DOCKER_AUTOSSH_BRANCH=master

# To change this for another repo
# - global replace: DOCKER_AUTOSSH -> ...
# - global replace: docker-autossh -> ...

echo "#### coldstart.sh has started."


#########
# clone #
#########

echo "Cloning the branch '$DOCKER_AUTOSSH_BRANCH' of docker-autossh."

# rm
cd ~
rm -rf ~/docker-autossh

# clone
git clone https://github.com/sejnub/docker-autossh.git

# checkout
cd ~/docker-autossh
git checkout $DOCKER_AUTOSSH_BRANCH
cd ~


#########
# build #
#########

cd ~; cd ~/docker-autossh/scripts
./build.sh


#######
# run #
#######

cd ~; cd ~/docker-autossh/scripts
./run.sh


echo "#### coldstart.sh has ended."
