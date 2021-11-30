#!/usr/bin/jq -f

.ip as $ip | .services[] | .port as $port | select(.telnet != null) | .banner as $banner | [$ip,$port,$banner]|@tsv
