#!/bin/bash

ips=()
while IFS= read -r ip; do
    ips+=("$ip")
done
ip_list=$(IFS=,; echo "${ips[*]}")
echo "ip: {$ip_list}"
