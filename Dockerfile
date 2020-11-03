FROM alpine:3.11
LABEL maintainer="Jeronimo Diaz <jeronimo.telec@gmail.com>"

COPY bin/ /usr/local/bin/
COPY conf/ /root/conf/
COPY entrypoint.sh /

RUN apk --no-cache add ca-certificates gettext libintl postfix cyrus-sasl-plain cyrus-sasl-login tzdata rsyslog supervisor \
    && cp /usr/bin/envsubst /usr/local/bin/ \
    && apk --no-cache del gettext \
    && ln -fs /root/conf/rsyslog.conf /etc/rsyslog.conf \
    && ln -fs /root/conf/supervisord.conf /etc/supervisord.conf

EXPOSE 25

VOLUME ["/var/log/smtp-relay"]

CMD ["/bin/sh"]

ENTRYPOINT ["/entrypoint.sh"]
