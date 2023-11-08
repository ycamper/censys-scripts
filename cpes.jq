#!/usr/bin/jq -f

#.service_name
.ip as $ip   |
 .services[] | .service_name as $sname |  
    select(.software!=null) |
        (
            .port as $port | (
                .software[] |
                    select(.uniform_resource_identifier!=null) | (
                        [$ip,$port,$sname,.uniform_resource_identifier]
                    ) | @tsv
            )
        )

