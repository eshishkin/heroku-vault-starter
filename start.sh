#!/bin/bash

set -e

echo "Starting Vault Server..."

./dev-config.sh > /tmp/config.json

nohup vault server -config=/tmp/config.json

