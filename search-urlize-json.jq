#!/usr/bin/jq -rf

.[] | . | .ip as $ip | .name as $name | .matched_services[] | 
 {
   name:$name,
   ip:$ip,
   sn:.extended_service_name|ascii_downcase,
   port:.port
  } | {
    host: "\(.sn)://\(.ip):\(.port)", 
    hostname:"\(.name)"
  }
