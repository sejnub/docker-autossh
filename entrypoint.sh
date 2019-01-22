#!/bin/sh

FORWARDS_CMD=""
for FORWARD in ${HOST_FORWARDS//,/ }; do
    echo ${FORWARD}
    FORWARDS_CMD="${FORWARDS_CMD} -L ${FORWARD}"
done


echo "################################################################"
echo "HOST_NAME     = '$HOST_NAME'"
echo "HOST_PORT     = '$HOST_PORT'"
echo "HOST_USER     = '$HOST_USER'"
echo "HOST_PRIV_KEY = '$HOST_PRIV_KEY'"
echo "HOST_FORWARDS = '$HOST_FORWARDS'"
echo "FORWARDS_CMD  = '$FORWARDS_CMD'"
echo "################################################################"




exec /usr/bin/autossh             \
  -o ServerAliveInterval=60       \
  -o ServerAliveCountMax=3        \
  -o StrictHostKeyChecking=no     \
  -o UserKnownHostsFile=/dev/null \
  -N                              \
  ${FORWARDS_CMD}                 \
  -i ~/HOST_PRIV_KEY              \
  -l $HOST_USER                   \
  -p $HOST_PORT                   \
  ${HOST_NAME}
