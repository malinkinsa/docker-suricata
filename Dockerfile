FROM alpine:3.13.4 AS builder

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
    libmaxminddb-dev \
    lua-dev \
    lz4-dev \
    make \
    musl-dev \
    nss-dev \
    pcre-dev \
    python3 \
    py3-yaml \
    rust \
    tar \
    yaml-dev \
    wget \
    zlib-dev

WORKDIR /opt

RUN \
    wget https://www.openinfosecfoundation.org/download/suricata-6.0.3.tar.gz && \
    tar xzf suricata-6.0.3.tar.gz

WORKDIR /opt/suricata-6.0.3/

RUN ./configure \
    --prefix=/usr/ \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --enable-geoip \
    --disable-shared \
    --disable-gccmarch-native \
    --enable-lua \
    --enable-nfqueue \
    --enable-hiredis

RUN \
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
    libmaxminddb \
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
    zlib \
    lua \
    lz4 \
    lz4-libs

COPY --from=builder /suricata-builder /

RUN \
    mkdir -p /var/log/suricata && \
    mkdir -p /var/run/suricata

RUN \
    suricata-update update-sources && \
    suricata-update enable-source oisf/trafficid && \
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