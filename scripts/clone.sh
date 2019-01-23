#!/bin/bash

export DOCKER_AUTOSSH_BRANCH=master

# To change this for another repo
# - global replace: DOCKER_AUTOSSH -> ...
# - global replace: docker-autossh -> ...

echo "#### clone.sh has started."


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

echo "#### clone.sh has ended."
