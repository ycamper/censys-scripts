#!/usr/bin/jq -rf

.data |
 .id as $ip |
 .attributes.last_analysis_stats |
  if .suspicious > 0 or .malicious > 0 then {
    is_malicious:true
  } else {
    is_malicious: false
  } end |
[$ip,.is_malicious]|@csv
