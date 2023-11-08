#!/usr/bin/jq -rf

.[] | . |
 .ip as $ip |
 .matched_services[] |
  {
    ip: $ip,
    sn: .extended_service_name | ascii_downcase,
    port: .port
  } |
  "\(.sn)://\(.ip):\(.port)"
