#!/bin/sh

FORWARDS_CMD=""
for FORWARD in ${HOST_FORWARDS//,/ }; do
    echo ${FORWARD}
    FORWARDS_CMD="${FORWARDS_CMD} -L ${FORWARD}"
done

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
  