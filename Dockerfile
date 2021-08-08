FROM alpine:3.14 AS builder

RUN apk add --no-cache \
    automake \
    autoconf \
    cargo \
    cbindgen \
    elfutils-dev \
    file-dev \
    gcc \
    git \
    hiredis-dev \
    jansson-dev \
    libpcap-dev \
    libelf \
    libbpf-dev \
    libnetfilter_queue-dev \
    libnetfilter_log-dev \
    libtool \
    linux-headers \
    libcap-ng-dev \
    make \
    musl-dev \
    nss-dev \
    pcre-dev \
    python3 \
    py3-yaml \
    rust \
    yaml-dev \
    wget \
    zlib-dev

WORKDIR /opt

RUN \
    https://www.openinfosecfoundation.org/download/suricata-6.0.3.tar.gz && \
    tar xzf suricata-6.0.3.tar.gz

WORKDIR /opt/suricata-6.0.3

RUN \
    ./configure && \
    --disable-gccmarch-native \
    --enable-nfqueue \
    --enable-hiredis \
    --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --disable-shared && \
    make && \
    make install-full DESTDIR=/suricata-builder && \
    rm -rf /suricata-builder/var

FROM alpine:3.14 AS runner

RUN apk add --no-cache \
    bash \
    hiredis \
    jansson \
    libcap \
    libcap-ng \
    libpcap \
    libelf \
    libbpf \
    libnetfilter_queue \
    libnetfilter_log \
    libmagic \
    logrotate \
    nss \
    pcre \
    python3 \
    py3-yaml \
    shadow \
    yaml \
    zlib

COPY --from=builder /suricata-builder /

RUN \
    mkdir -p /var/log/suricata && \
    mkdir -p /var/run/suricata

RUN \
    suricata-update update-sources && \
    suricata-update enable-source oisf/trafficid && \
    suricata-update enable-source et/open && \
    suricata-update enable-source ptresearch/attackdetection && \
    suricata-update --no-test --no-reload

RUN \
    addgroup suricata && \
    adduser -S -G suricata suricata && \
    chown -R suricata:suricata /etc/suricata && \
    chown -R suricata:suricata /var/log/suricata && \
    chown -R suricata:suricata /var/lib/suricata && \
    chown -R suricata:suricata /var/run/suricata

VOLUME /etc/suricata
VOLUME /etc/suricata/rules
VOLUME /var/log/suricata

COPY /files/docker-entrypoint.sh /
RUN chmod u+x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]