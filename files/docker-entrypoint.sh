#!/usr/bin/env bash
exec /usr/bin/suricata -c /etc/suricata/suricata.yaml -i $NIC $CONFIG
