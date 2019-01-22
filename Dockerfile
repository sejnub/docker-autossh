FROM easypi/alpine-arm

ARG HOST_PRIV_KEY
ARG HOST_DEFAULT_USER

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
    FORWARDS=5601:127.0.0.1:5601,9000:127.0.0.1:9000 

RUN mkdir /root/.ssh
VOLUME /root/.ssh 

# HB
RUN echo "$HOST_PRIV_KEY" > ~/keyfile
RUN chmod 0600 ~/keyfile

ADD entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
