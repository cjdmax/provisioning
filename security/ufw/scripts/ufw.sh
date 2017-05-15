#!/bin/bash
set -e

ufw --force reset
ufw allow ssh
for ip in $(curl -s 169.254.42.42/conf | sed -nE 's/VOLUMES_[0-9]+_EXPORT_URI=.*nbd:\/\/([^:]+):.*/\1/p' |uniq);
  do
  ufw allow from $ip
done
ufw allow in on ${private_interface} to any port ${vpn_port} # vpn on private interface
ufw allow in on ${vpn_interface}
ufw allow in on ${kubernetes_interface} # Kubernetes pod overlay interface
ufw allow 6443 # Kubernetes API secure remote port
ufw allow 80
ufw allow 443
ufw default deny incoming
ufw --force enable
ufw status verbose
