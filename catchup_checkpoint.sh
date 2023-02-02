#!/bin/bash

while true; do
  a=$(curl -s --location --request POST 'https://fullnode.testnet.sui.io:443/' --header 'Content-Type: application/json' --data-raw '{"jsonrpc":"2.0", "id":1,"method":"sui_getLat
  b=$(curl -q localhost:9184/metrics 2>/dev/null | grep '^highest_synced_checkpoint' | awk '{print $2}')
  dif=$((b-a))
  if [ $dif -gt 0 ]; then
    behind_or_ahead="ahead"
  else
    behind_or_ahead="behind"
  fi
  echo "$dif checkpoint $behind_or_ahead (us:$b them:$a)"
done
