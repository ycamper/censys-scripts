#!/usr/bin/jq -f 

.ip as $ip | .services[] | .port as $port |
 select(.http != null) |
  .http.response.body as $body |
  [$ip,$port,$body]|@csv

