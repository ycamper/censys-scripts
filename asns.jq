#!/usr/bin/jq -rf

.ip as $ip | .autonomous_system | [$ip, .asn, .name, .bgp_prefix, .country_code, .description]|@tsv 
