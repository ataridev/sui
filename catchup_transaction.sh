#!/bin/bash

while true; do
  a=$(curl -s --location --request POST https://fullnode.testnet.sui.io:443 \
  --header 'Content-Type: application/json' \
  --data-raw '{ "jsonrpc":"2.0", "method":"sui_getTotalTransactionNumber","id":1}' | awk -F 'result":' '{print $2}' | awk -F ',' '{print $1}')
  b=$(curl -s --location --request POST http://127.0.0.1:9000/ \
  --header 'Content-Type: application/json' \
  --data-raw '{ "jsonrpc":"2.0", "method":"sui_getTotalTransactionNumber","id":1}'  | awk -F 'result":' '{print $2}' | awk -F ',' '{print $1}')
  dif=$((b-a))
  if [ $dif -gt 0 ]; then
    behind_or_ahead="ahead"
  else
    behind_or_ahead="behind"
  fi
  echo "$dif transactions $behind_or_ahead (us:$b them:$a)"
done
