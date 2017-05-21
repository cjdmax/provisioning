#!/bin/sh
set -e

rm -f /opt/etcd-${version}-linux-amd64.tar.gz
rm -rf /opt/etcd && mkdir -p /opt/etcd

curl -L https://github.com/coreos/etcd/releases/download/${version}/etcd-${version}-linux-amd64.tar.gz \
  -o /opt/etcd-${version}-linux-amd64.tar.gz
tar xzvf /opt/etcd-${version}-linux-amd64.tar.gz -C /opt/etcd --strip-components=1
