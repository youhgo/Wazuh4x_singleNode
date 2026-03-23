#!/bin/bash

set -e

DIR_NAME="wazuh-certificates"
NODES=("wazuh.indexer" "admin" "wazuh.manager" "wazuh.dashboard")
SUBJECT_BASE="/C=US/L=California/O=Wazuh/OU=Wazuh"

mkdir -p "$DIR_NAME"
cd "$DIR_NAME"

openssl genrsa -out root-ca-key.pem 2048
openssl req -new -x509 -sha256 -key root-ca-key.pem -out root-ca.pem -days 3650 -subj "${SUBJECT_BASE}/CN=Wazuh-CA"

for node in "${NODES[@]}"; do
    openssl genrsa -out "${node}-key.pem" 2048 2>/dev/null
    openssl req -new -key "${node}-key.pem" -out "${node}.csr" -subj "${SUBJECT_BASE}/CN=${node}"
    openssl x509 -req -in "${node}.csr" -CA root-ca.pem -CAkey root-ca-key.pem -CAcreateserial -out "${node}.pem" -days 730 -sha256 2>/dev/null
done

chmod 644 *.pem
rm -f *.csr *.srl
ls -lh