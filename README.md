# Suricata
---
![Docker Pulls](https://img.shields.io/docker/pulls/malinkinsa/suricata)
Suricata Docker Image with enabled profiling and debug.

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
    - CONFIG - any others command line options of [suricata](https://suricata.readthedocs.io/en/suricata-5.0.4/command-line-options.html); For example: ``` "-i eth0"``` or ```"-i eth0 -S <filename.rules>"```

---
## To-Do
---

- [ ] Add example with docker-compose;

