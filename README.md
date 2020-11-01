# Suricata
---
![Docker Pulls](https://img.shields.io/docker/pulls/malinkinsa/suricata)

Suricata Docker Image with enabled profiling.
Packet profiling is convenient in case you would like to know how long packets take to be processed. It is a way to figure out why certain packets are being processed quicker than others, and this way a good tool for developing Suricata.

## Supported tags
```latest``` ```6.0.0``` ```5.0.3```

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
---

- [x] Add example with docker-compose;

