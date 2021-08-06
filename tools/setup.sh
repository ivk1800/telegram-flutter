#!/usr/bin/env bash

app_id=$1
app_hash=$2
encryption_key=$3

config_path='../app/assets/tdlib/'

mkdir -p ${config_path}
echo "apiId:$app_id
apiHash:$app_hash
encryptionKey:$encryption_key
" > "${config_path}config.txt"