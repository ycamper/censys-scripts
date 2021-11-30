#!/usr/bin/jq -rf

.ip as $ip   |
 .services[] | 
    select(.software!=null) |
        (
            .port as $port | (
                .software[] |
                    select(.uniform_resource_identifier!=null) | (
                        [$ip,$port,.uniform_resource_identifier]
                    ) | @tsv
            )
        )

