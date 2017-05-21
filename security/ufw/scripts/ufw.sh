#!/bin/bash
set -e

ufw status verbose
ufw --force reset
ufw allow ssh
ufw allow in on ${private_interface} to any port ${vpn_port} # vpn on private interface
ufw allow in on ${vpn_interface}
ufw allow in on ${kubernetes_interface} # Kubernetes pod overlay interface
ufw allow 6443 # Kubernetes API secure remote port
ufw allow 80
ufw allow 443
# scaleway cargocult changes start
# scw kernel doesn't like logging?
ufw logging off
# whitelist NBD volume servers
oc-metadata | sed -nE 's/VOLUMES_[0-9]+_EXPORT_URI=.*nbd:\/\/([^:]+):.*/\1/p' |uniq | xargs -n 1 ufw allow from
# override default input policy to accept
sed -i 's/DEFAULT_INPUT_POLICY="DROP"/DEFAULT_INPUT_POLICY="ACCEPT"/g' /etc/default/ufw
# disable ipv6; scw doesn't like this either
sed -i 's/IPV6=yes/IPV6=no/g' /etc/default/ufw
# add a default drop of sorts at the absolute end of rules
sed -i 's/^COMMIT/-A ufw-reject-input -j DROP\nCOMMIT/' /etc/ufw/after.rules
# scaleway changes end
ufw --force enable
ufw status verbose
