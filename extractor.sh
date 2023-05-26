#!/bin/bash

swagger_file="swagger.json"

output=$(jq -r '.paths | to_entries[] | "\(.key): \(.value | with_entries(select(.key != "parameters")) | keys[])" | tojson' "$swagger_file" | awk -F': ' '{gsub(/"/, "", $1); gsub(/"/, "", $2); print "{\"path\": \"" $1 "\", \"method\": \"" $2 "\"}"}')

echo "$output" > extracted.json
