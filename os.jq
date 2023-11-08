#!/usr/bin/jq -f

{
    ip: .ip,
    os: .operating_system | select( .product != null) | .product
}
