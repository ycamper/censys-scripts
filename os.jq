#!/usr/bin/jq -rf

.ip as $ip | .operating_system | select(.product != null) | [$ip, .product]|@tsv
