#!/bin/bash

set -e

echo "Starting Vault Server..."

./config.sh > /tmp/config.json

nohup bash unsealer.sh &
vault server -config=/tmp/config.json

