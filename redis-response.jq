#!/usr/bin/jq -rf

.ip as $ip | .services[] | .port as $port | select (.redis != null) | [$ip,$port,.redis.ping_response]|@tsv
