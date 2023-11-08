#!/usr/bin/jq -f

{
    ip: .ip,
    asn: .autonomous_system | {name: .name, as : .asn }
}
