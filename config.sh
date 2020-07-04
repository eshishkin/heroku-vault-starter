#!/bin/bash

set -e

cat << EOF

storage "postgresql" {
  connection_url = "${DATABASE_URL:?}"
}

listener "tcp" {
 address = "127.0.0.1:8080"
 tls_disable = 0
}

EOF


