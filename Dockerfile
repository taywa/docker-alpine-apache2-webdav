FROM alpine:3.8

ENV LANG en_US.utf8

RUN apk add --update \
        curl \
        apache2-webdav \
        apache2-ssl \
        apache2-ctl \
        apache2-utils \
        ca-certificates \
        && \
    apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing pure-ftpd && \
    curl -Ls -o /tmp/s6-overlay.tar.gz https://github.com/just-containers/s6-overlay/releases/download/v1.21.7.0/s6-overlay-amd64.tar.gz \
    && tar xfz /tmp/s6-overlay.tar.gz -C / \
    && curl -Ls -o /tmp/socklog.tar.gz https://github.com/just-containers/socklog-overlay/releases/download/v2.2.1-0/socklog-overlay-amd64.tar.gz \
    && tar xfz /tmp/socklog.tar.gz -C / \
    && rm -f /tmp/s6-overlay.tar.gz \
    && update-ca-certificates \
    && deluser xfs \
    && delgroup www-data \
    && rm -rfv /var/cache/apk/*
ADD files.tar /
ENTRYPOINT ["/init"]
EXPOSE 80 443
EXPOSE 21 30000-30020
