#!/usr/bin/jq -rf

#jq -r '.[]|.ip as $ip|.services[]|[$ip,.port,.service_name]|@tsv'
.[] |
 .ip as $ip | .name as $name |
 .services[] |
   [$ip, $name, .port, .service_name]|@tsv
