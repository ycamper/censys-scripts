#!/usr/bin/jq -rf
.ip as $ip | .services[] | .port as $port |  select(.http != null) | .http.response | select(.html_title != null) | [$ip,$port,.html_title]|@tsv 
