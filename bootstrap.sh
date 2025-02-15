#!/bin/sh

echo "Setting up primary server 1"
k3sup install --host 10.174.237.31 \
--user ubuntu \
--cluster \
--local-path kubeconfig \
--context default \
--k3s-extra-args "--disable traefik"

echo "Fetching the server's node-token into memory"

export NODE_TOKEN=$(k3sup node-token --host 10.174.237.31 --user ubuntu)

echo "Setting up additional server: 2"
k3sup join \
--host 10.174.237.2 \
--server-host 10.174.237.31 \
--server \
--node-token "$NODE_TOKEN" \
--user ubuntu \
--k3s-extra-args "--disable traefik" &

echo "Setting up additional server: 3"
k3sup join \
--host 10.174.237.115 \
--server-host 10.174.237.31 \
--server \
--node-token "$NODE_TOKEN" \
--user ubuntu \
--k3s-extra-args "--disable traefik" &

echo "Setting up worker: 1"
k3sup join \
--host 10.174.237.22 \
--server-host 10.174.237.31 \
--node-token "$NODE_TOKEN" \
--user ubuntu &

echo "Setting up worker: 2"
k3sup join \
--host 10.174.237.83 \
--server-host 10.174.237.31 \
--node-token "$NODE_TOKEN" \
--user ubuntu &

