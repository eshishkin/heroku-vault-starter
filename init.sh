#!/bin/bash

generate_unseal_request() {
cat <<EOF
    {"key": "${VAULT_UNSEAL_KEY}"}
EOF
}

VAULT_STARTED=0

for i in {1..10}
do
  echo "Requesting http://127.0.0.1:8080/v1/sys/health"
  RESPONSE=$(curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:8080/v1/sys/health)
  echo "Response is ${RESPONSE}"

  if [ ${RESPONSE} -eq 200 ]; then
    echo "Vault Server is running"
    VAULT_STARTED=1
    break
  elif [ ${RESPONSE} -eq 501 ]; then
    echo "Vault Server is running, but not yet initialized"
    VAULT_STARTED=1
    break
  elif [ ${RESPONSE} -eq 503 ]; then
    echo "Vault Server is running, but it is sealead"
    VAULT_STARTED=1
    break
  else
    echo "Sleeping..."
    sleep 5
  fi
done


if [ ${VAULT_STARTED} -ne 1 ]; then
  echo "Vault Service is down"
  exit 0
fi

if [[ -z ${VAULT_UNSEAL_KEY+x} ]]; then
  echo "Unseal key is not provided -- vault needs to be manually unsealed"
else
  echo "Trying to unseal Vault"
  curl -X PUT -d "$(generate_unseal_request)" http://127.0.0.1:8080/v1/sys/unseal
  echo "Unseal request done"
fi

echo "Starting Nginx..."
bash nginx-start.sh
