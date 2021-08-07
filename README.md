# Suricata

- [Suricata](#suricata)
  - [About](#about)
  - [Build info](#build-info)
  - [Supported tags](#supported-tags)
  - [Usage](#usage)
  - [Usage via docker-compose](#usage-via-docker-compose)
  - [To-Do](#to-do)

## About
Suricata Docker Image based on Centos 7 image.

## Build info
<details>
<summary>Expand</summary>

```
Suricata Configuration:
  AF_PACKET support:                       yes
  eBPF support:                            no
  XDP support:                             no
  PF_RING support:                         no
  NFQueue support:                         no
  NFLOG support:                           no
  IPFW support:                            no
  Netmap support:                          no 
  DAG enabled:                             no
  Napatech enabled:                        no
  WinDivert enabled:                       no

  Unix socket enabled:                     yes
  Detection enabled:                       yes

  Libmagic support:                        yes
  libnss support:                          yes
  libnspr support:                         yes
  libjansson support:                      yes
  hiredis support:                         no
  hiredis async with libevent:             no
  Prelude support:                         no
  PCRE jit:                                yes
  LUA support:                             yes
  libluajit:                               no
  GeoIP2 support:                          yes
  Non-bundled htp:                         no
  Hyperscan support:                       no
  Libnet support:                          no
  liblz4 support:                          yes
  HTTP2 decompression:                     no

  Rust support:                            yes
  Rust strict mode:                        no
  Rust compiler path:                      /usr/bin/rustc
  Rust compiler version:                   rustc 1.53.0 (Red Hat 1.53.0-1.el7)
  Cargo path:                              /usr/bin/cargo
  Cargo version:                           cargo 1.53.0
  Cargo vendor:                            yes

  Python support:                          yes
  Python path:                             /usr/bin/python3
  Python distutils                         yes
  Python yaml                              yes
  Install suricatactl:                     yes
  Install suricatasc:                      yes
  Install suricata-update:                 yes

  Profiling enabled:                       no
  Profiling locks enabled:                 no

  Plugin support (experimental):           yes
```
</details>

## Supported tags
```latest```

## Usage
- Create volumes:
```
docker volume create suricata
docker volume create rules
docker volume create suricata_log
```
- Pull image (latest or specified version)
```
docker pull malinkinsa/suricata:latest
```
- Launch container
```
docker run --rm -it \
	--net=host \
	--cap-add=net_admin \
	--cap-add=sys_nice \
	-v suricata:/etc/suricata \
	-v rules:/etc/suricata/rules \
	-v suricata_log:/var/log/suricata \
	-e CONFIG="-i eth0" \
	malinkinsa/suricata:latest
```
- Variables:
    - CONFIG - any others command line options of [suricata](https://suricata.readthedocs.io/en/latest/command-line-options.html); For example: ``` "-i eth0"``` or ```"-i eth0 -S <filename.rules>"```

## Usage via docker-compose
- Clone repo
```
git clone git@github.com:malinkinsa/docker-suricata.git
cd docker-suricata/docker-compose/
```
- Configure command line options and tag in docker-compose.yml
- Launch container
```
docker-compose up -d
```
---
## To-Do

- [x] Add example with docker-compose;
- [ ] Add version with enabled profiling;
- [ ] Add NFQ;