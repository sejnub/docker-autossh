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


echo "FORWARDS_CMD = '${FORWARDS_CMD}'"
echo
echo "Keyfile has content: '$(cat ~/HOST_PRIV_KEY)'"
echo
HOST_USER="$(cat ~/HOST_USER)"
echo "cat HOST_USER = '$(cat ~/HOST_USER)'"
echo "HOST_USER = '$HOST_USER'"



exec /usr/bin/autossh           \
-i ~/HOST_PRIV_KEY              \
-l $HOST_USER                   \
-o ServerAliveInterval=60       \
-o ServerAliveCountMax=3        \
-o StrictHostKeyChecking=no     \
-o UserKnownHostsFile=/dev/null \
-N ${FORWARDS_CMD}              \
${TUNNEL_SERVER}