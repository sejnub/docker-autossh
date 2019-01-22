#!/bin/sh

FORWARDS_CMD=""
for FORWARD in ${HOST_FORWARDS//,/ }; do
    echo ${FORWARD}
    FORWARDS_CMD="${FORWARDS_CMD} -L ${FORWARD}"
done


RUN echo "################################################################"
RUN echo "HOST_NAME     = '$HOST_NAME'"
RUN echo "HOST_PORT     = '$HOST_PORT'"
RUN echo "HOST_USER     = '$HOST_USER'"
RUN echo "HOST_PRIV_KEY = '$HOST_PRIV_KEY'"
RUN echo "HOST_FORWARDS = '$HOST_FORWARDS'"
RUN echo "FORWARDS_CMD  = '$FORWARDS_CMD'"
RUN echo "################################################################"




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
