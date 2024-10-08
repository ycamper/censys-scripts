#!/usr/bin/env python
import sys
import json

host_data = {}

for line in sys.stdin:
    entry = json.loads(line.strip())
    host = entry["host"]
    hostname = entry["hostname"]
    
    if host not in host_data or hostname == "null":
        host_data[host] = hostname

filtered_entries = [{"host": host, "hostname": hostname} for host, hostname in host_data.items()]

for entry in filtered_entries:
    print(json.dumps(entry))
