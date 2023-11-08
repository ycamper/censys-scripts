#!/usr/bin/jq -rf

.ip as $ip|.services[]|.port as $port|.transport_protocol as $tp|.service_name as $sn|select(.jarm != null)|[$ip,$tp,$port,$sn,.jarm.fingerprint]|@csv


