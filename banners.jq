#!/usr/bin/jq -rf

#'.ip as $ip|.services[]|[$ip,.transport_protocol,.port,.service_name]|@tsv'
.ip as $ip | .services[] | 
[
    $ip,
    .transport_protocol,
    .port,
    .service_name,
    .banner
] | @csv
