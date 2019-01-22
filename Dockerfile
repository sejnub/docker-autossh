FROM easypi/alpine-arm

ARG HOST_NAME
ARG HOST_PORT
ARG HOST_USER
ARG HOST_PRIV_KEY
ARG HOST_FORWARDS


RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk add --update autossh \
    && rm -rf /var/lib/apt/lists/*

ENV AUTOSSH_LOGFILE=/dev/stdout		\
    AUTOSSH_GATETIME=30         	\
    AUTOSSH_POLL=10             	\
    AUTOSSH_FIRST_POLL=30       	\
    AUTOSSH_PORT=0			        \
    AUTOSSH_DEBUG=1            		\
    AUTOSSH_LOGLEVEL=1          	\
    HOST_NAME=$HOST_NAME            \
    HOST_PORT=$HOST_PORT            \
    HOST_USER=$HOST_USER            \
    HOST_PRIV_KEY=$HOST_PRIV_KEY    \
    HOST_FORWARDS=$HOST_FORWARDS

echo "################################################################"
echo "HOST_NAME     = '$HOST_NAME'"
echo "HOST_PORT     = '$HOST_PORT'"
echo "HOST_USER     = '$HOST_USER'"
echo "HOST_PRIV_KEY = '$HOST_PRIV_KEY'"
echo "HOST_FORWARDS = '$HOST_FORWARDS'"
echo "################################################################"

# What is this for?
RUN mkdir /root/.ssh
VOLUME /root/.ssh

# HB
RUN echo "HOST_PRIV_KEY = '$HOST_PRIV_KEY'"
RUN echo "$HOST_PRIV_KEY" > ~/HOST_PRIV_KEY
RUN chmod 0600 ~/HOST_PRIV_KEY

ADD entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
