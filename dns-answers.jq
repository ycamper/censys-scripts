#!/usr/bin/jq -f

.name as $name | .data | select(.answers != null) | .answers| .[] | select(.type == "A") | [$name,.answer]|@tsv
