FROM easypi/alpine-arm

ARG HOST_USER
ARG HOST_PRIV_KEY

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
    TUNNEL_SERVER=elk.bunjes.net	\
    FORWARDS=*:5601:127.0.0.1:5601,9000:0.0.0.0:9000 

RUN mkdir /root/.ssh
VOLUME /root/.ssh 

# HB
RUN echo "HOST_USER = '$HOST_USER'"
RUN echo "$HOST_USER" > ~/HOST_USER

RUN echo "HOST_PRIV_KEY = '$HOST_PRIV_KEY'"
RUN echo "$HOST_PRIV_KEY" > ~/HOST_PRIV_KEY
RUN chmod 0600 ~/HOST_PRIV_KEY

ADD entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
