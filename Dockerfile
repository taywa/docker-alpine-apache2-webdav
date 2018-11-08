FROM alpine:3.8

ENV LANG en_US.utf8

RUN apk add --update \
        curl \
        apache2-webdav \
        apache2-ssl \
        apache2-ctl \
        apache2-utils \
        ca-certificates \
        vsftpd \
        linux-pam \
        && \
    curl -Ls -o /tmp/s6-overlay.tar.gz https://github.com/just-containers/s6-overlay/releases/download/v1.21.7.0/s6-overlay-amd64.tar.gz \
    && tar xfz /tmp/s6-overlay.tar.gz -C / \
    && rm -f /tmp/s6-overlay.tar.gz \
    && update-ca-certificates \
    && deluser xfs \
    && delgroup www-data \
    && apk add -U build-base \
        linux-pam-dev \
        tar \
    && mkdir pam_pwdfile \
        && cd pam_pwdfile \
        && curl -sSL https://github.com/tiwe-de/libpam-pwdfile/archive/v1.0.tar.gz | tar xz --strip 1 \
        && make install \
        && cd .. \
        && rm -rf pam_pwdfile \
    && apk del build-base \
        curl \
        linux-pam-dev \
        tar \
    && rm -rfv /var/cache/apk/*
ADD files.tar /
ENTRYPOINT ["/init"]
EXPOSE 80 443
EXPOSE 21 21100-21110
