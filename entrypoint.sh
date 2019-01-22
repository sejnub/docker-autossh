#!/bin/sh


if [ ! -z ${1+x} ] && [ ${1} == "shell" ]
then
    /bin/sh
    exit 0
fi

if [ $# -gt 0 ]
then
    exec $@
    exit 0
fi

FORWARDS_CMD=""
for FORWARD in ${FORWARDS//,/ }
do
    echo ${FORWARD}
    FORWARDS_CMD="${FORWARDS_CMD} -L ${FORWARD}"
done

exec /usr/bin/autossh -o ServerAliveInterval=60 -o ServerAliveCountMax=3 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -N ${FORWARDS_CMD} ${TUNNEL_SERVER}