#!/usr/bin/env bash

if [ -z "$1" ]
  then
    ROOT="$PWD/certs/"
  else
    ROOT="$PWD/$1/certs/"
fi

if [ -d "$ROOT" ]; then
  echo "Deleting $ROOT"
  chmod -R 0755 "$ROOT"
  rm -rf "$ROOT"
fi

mkdir -p "$ROOT"

docker pull eventstore/es-gencert-cli:1.0.1
docker run --rm --volume "$ROOT:/tmp" --user "$(id -u):$(id -g)" eventstore/es-gencert-cli:1.0.1 create-ca -out /tmp/ca
docker run --rm --volume "$ROOT:/tmp" --user "$(id -u):$(id -g)" eventstore/es-gencert-cli:1.0.1 create-node -ca-certificate /tmp/ca/ca.crt -ca-key /tmp/ca/ca.key -out /tmp/node -ip-addresses 127.0.0.1 -dns-names localhost
cat "${ROOT}ca/ca.key" "${ROOT}ca/ca.crt" > "${ROOT}ca/ca.pem"

echo "Created Certificate Authority certificate at ${ROOT}ca"
ls -al "${ROOT}ca"

echo "Created Node certificate at ${ROOT}node"
ls -al "${ROOT}node"


if [ "$2" == "--secure" ]
  then
    echo "Limit access to read and write for $USER only with chmod 0600 (--secure)"
    chmod -R 0600 "$ROOT"
  else
    echo "Limit access to read and write for $USER only with chmod 0755 (--insecure)"
    chmod -R 0755 "$ROOT"
fi

echo "Certificates creation finished!"
