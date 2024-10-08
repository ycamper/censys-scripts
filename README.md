
### search-hosts.jq

Dumps a raw list of IP addresses from a `censys search` output:

```shell
$ censys search 'services.service_name=REDIS' --pages 1 | ./search-hosts.jq -r
1.0.135.154
1.11.70.6
1.12.36.161
1.12.37.13
```

### search-services.jq

Like `search-hosts.jq`, but for services:

```shell
$ censys search 'services.service_name=REDIS' --pages 1 | ./search-services.jq
1.0.135.154	22	SSH
1.0.135.154	80	HTTP
1.0.135.154	443	HTTP
1.0.135.154	888	HTTP
```

### asns.jq

Summary of AS information for one or more Censys document results

```shell
$ censys view 1.1.1.1 | ./asns.jq
1.1.1.1	13335	CLOUDFLARENET	1.1.1.0/24	US	CLOUDFLARENET
```

### banners.jq

Summary of banners assosiated with one or more Censys document results

```shell
$ censys view 192.168.0.161 | ./banners.jq
192.168.0.161	TCP	22	SSH	    SSH-1.99-Cisco-1.25
192.168.0.161	TCP	23	TELNET	\r\nAstSW>
192.168.0.161	TCP	80	HTTP	HTTP/1.1 401 Unauthorized\nServer: cisco-IOS\nConnection: close\nDate: <REDACTED>\nAccept-Ranges: none\nWww-Authenticate: Basic realm="level_15_access"
192.168.0.161	TCP	443	HTTP	HTTP/1.1 401 Unauthorized\nServer: cisco-IOS\nConnection: close\nDate: <REDACTED>\nAccept-Ranges: none\nWww-Authenticate: Basic realm="level_15_access"
```

### censys-cve.sh

Script to build, run, and maintain [NVDTools](https://github.com/facebookincubator/nvdtools) using Censys data to obtain CVE's based on CPE information.

```shell
$ ./censys-cve.sh 192.168.0.1 
CVE-2021-2226	4.9	4.0	cpe:/a:oracle:mysql
CVE-2020-11656	9.8	7.5	cpe:/a:oracle:mysql
CVE-2021-35635	4.9	4.0	cpe:/a:oracle:mysql
CVE-2013-2392	0.0	4.0	cpe:/a:oracle:mysql
CVE-2021-2305	4.9	4.0	cpe:/a:oracle:mysql
CVE-2016-7480	9.8	7.5	cpe:/a::php:5.6.18,cpe:/a:php:php:5.6.18
CVE-2019-2494	4.9	4.0	cpe:/a:oracle:mysql
CVE-2021-35645	4.9	4.0	cpe:/a:oracle:mysql
CVE-2019-2593	4.9	4.0	cpe:/a:oracle:mysql
CVE-2016-7417	9.8	7.5	cpe:/a::php:5.6.18,cpe:/a:php:php:5.6.18
```

### cpes.jq

Get a summary list of CPE's associated with one or more Censys document results.

```shell
censys view 192.168.0.1 | ./cpes.jq
192.168.0.1	22	    cpe:2.3:a:openbsd:openssh:7.1:*:*:*:*:*:*:*
192.168.0.1	80	    cpe:2.3:a:apache:http_server:2.4.16:*:*:*:*:*:*:*
192.168.0.1	80	    cpe:2.3:o:redhat:fedora_core:*:*:*:*:*:*:*:*
192.168.0.1	80	    cpe:2.3:a:*:php:5.6.18:*:*:*:*:*:*:*
192.168.0.1	80      cpe:2.3:a:php:php:5.6.18:*:*:*:*:*:*:*
192.168.0.1	3306	cpe:2.3:a:oracle:mysql:*:*:*:*:*:*:*:*
192.168.0.1	3306    cpe:2.3:a:mariadb:mariadb:*:*:*:*:*:*:*:*
```

### html-titles.jq

Summary of html titles associated with one or more Censys document results

```shell
$ censys view  192.168.0.1 | ./html-titles.jq 
192.168.0.1	80	    Document Moved
192.168.0.1	443	    \r\n\tGICHF\r\n
192.168.0.1	8090	\r\n\tGICHF\r\n
192.168.0.1	8091	\r\n\tGICHF\r\n
192.168.0.1	8092	Home Page
```

### jarms.jq

Get a summary of JARM's associated with one or more Censys document results

```shell
$ censys view  192.168.0.1 | ./jarms.jq
192.168.0.1	TCP	443	    HTTP	07d0bd0fd21d21d07c07d0bd07d21de77d7d390b8938342b77c0ea37fc40c4
192.168.0.1	TCP	10443	HTTP	2ad2ad16d2ad2ad22c2ad2ad2ad2ad427137ba8b28788db667d78592419afa
```

### os.jq

Get a summary of OS products associated with one or more Censys documents

```shell
$censys view  192.168.0.1 | ./os.jq 
192.168.0.1	Linux
```

### redis-response.jq

Get a summary of Redis command-responses with one or more Censys documents results

```shell
$ censys view 1.12.246.240 | ./redis-response.jq
1.12.246.240	6379	(Error: NOAUTH Authentication required.)
```

### search-urlize.jq

Turns matched services into its service-based URI

```shell
$ ./search-urlize.jq <<< $(censys search services.service_name=HTTP)
http://88.181.231.137:7201
https://88.181.231.137:9062
https://88.174.232.219:41302
http://88.174.232.219:53849

```

### dnsdb-format.jq

Not for Censys, but for DNSDB JSON output (passive DNS), this just makes human-readable timestamps:

```shell
% dnsdbq -j -i 89.147.108.171 | dnsdb-format.jq
{
  "count": 206,
  "time_first": "2023-06-28 04:29:37",
  "time_last": "2024-09-21 01:18:26",
  "rrname": "discomania.wiki.",
  "rrtype": "A",
  "rdata": [
    "89.147.108.171"
  ]
}
{
  "count": 83,
  "time_first": "2023-08-06 16:08:55",
  "time_last": "2024-08-02 11:18:39",
  "rrname": "www.discomania.wiki.",
  "rrtype": "A",
  "rdata": [
    "89.147.108.171"
  ]
}
```

### ips-to-censys.sh

Turn an input of IP addresses into a Censys-searchable string:

```shell
% printf "1.1.1.1\n2.2.2.2\n3.3.3.3\n" | ips-to-censys.sh
ip: {1.1.1.1,2.2.2.2,3.3.3.3}
```

### search-matched-services-short.jq

Parses out the matched services from a query and ouputs a `$IP:$PORT` combo:

```shell
% censys search --pages 5 'services.banner: "INFO {\"server_id\""' | search-matched-services-short.jq
38.83.104.147:4222
162.255.25.14:5222
162.255.25.14:4222
176.65.47.69:4222
149.255.31.168:4223
68.183.214.85:4222
103.60.204.109:4223
94.199.4.53:4222
159.203.137.93:5489
106.52.193.141:8300
144.24.181.188:4743
```

### search-urlize-json.jq

Like search-urlize.jq, but in JSON format. This is best used with virtual-hosts (name-based hosts) so you can separate the name from the IP

```shell
 % censys search --pages 1 --virtual-hosts ONLY 'services.service_name=HTTP' | search-urlize-json.jq -cr
{"host":"http://204.184.58.132:443","hostname":"libproxy.trcc.edu"}
{"host":"https://142.132.156.20:2096","hostname":"cpanel1.buyfasthosts.com"}
{"host":"http://142.132.156.20:80","hostname":"cpanel1.buyfasthosts.com"}
{"host":"https://142.132.156.20:443","hostname":"cpanel1.buyfasthosts.com"}
{"host":"https://142.132.156.20:2078","hostname":"cpanel1.buyfasthosts.com"}
```

### filter-duplicate-vhosts.py

Takes input from `search-urlize-json.jq` and filters out duplicate names; results with a bare-IP address take priority.

So let's say I have a query that can match port 443 on both a name-based host and the bare-IP; sometimes we know that the service sitting on the bare-IP is the exact same as the one on the name-based result, without this, a result can be big:

```shell
 % censys search 'ip: 3.208.127.243 and services.extended_service_name=HTTPS' --virtual-hosts INCLUDE | search-urlize-json.jq -cr
{"host":"https://3.208.127.243:443","hostname":"null"}
{"host":"https://3.208.127.243:443","hostname":"hello.n-able.com"}
{"host":"https://3.208.127.243:443","hostname":"00b51e42-0e1c-41a1-83a7-841f98b90b38.outrch.com"}
{"host":"https://3.208.127.243:443","hostname":"fa34ec77-402b-458d-a351-4f9c48e774a9.outrch.com"}
{"host":"https://3.208.127.243:443","hostname":"4883b2ba-05af-47f4-9942-a4b95b4595d4.outrch.com"}
... snip snip ...
```

So we just want to get one result for each unique host:

```shell
 % censys search 'ip: 3.208.127.243 and services.extended_service_name=HTTPS' --virtual-hosts INCLUDE | search-urlize-json.jq -cr | filter-duplicate-vhosts.py
{"host": "https://3.208.127.243:443", "hostname": "null"}
```

### vt-ip.go / vt-ip-malicious.jq

`vt-ip.go` is small golang script to query IPs via virus-total (and stay within limits). Also adds a bit of caching.
`vt-ip-malicious.jq` is just a JQ script that takes the output of `vt-ip.go` and determines if anything has been marked as malicious:

```shell
% censys search 'labels=c2' | search-hosts.jq -cr | vt-ip - | while read line; do vt-ip-malicious.jq; done
"194.87.39.116",false
"185.56.91.30",false
"1.1.1.1",true
```


### telnet-banner.jq

### services.jq

### Chaining

These tools are meant to be used in a chain, for example:

```shell
censys search 'services.service_name=REDIS' --pages 1 | ./search-hosts.jq | while read line; do censys view $line | ./redis-response.jq ; done
1.0.135.154	6379	(Error: NOAUTH Authentication required.)
1.11.70.6	6379	(Error: NOAUTH Authentication required.)
1.12.36.161	10037	(Error: NOAUTH Authentication required.)
1.12.36.161	10039	(Error: NOAUTH Authentication required.)
1.12.36.161	10042	(Error: NOAUTH Authentication required.)
1.12.36.161	10045	(Error: NOAUTH Authentication required.)
1.12.36.161	10048	(Error: NOAUTH Authentication required.)
1.12.36.161	10051	(Error: NOAUTH Authentication required.)
1.12.36.161	10065	(Error: NOAUTH Authentication required.)
1.12.37.13	5000	(Error: NOAUTH Authentication required.)
1.12.37.13	5001	(Error: NOAUTH Authentication required.)
1.12.37.13	5003	(Error: NOAUTH Authentication required.)
```

Or run through other programs:

```shell
$ censys search services.service_name=HTTP | ./search-urlize.jq | httpx -path /.env -sc

    __    __  __       _  __
   / /_  / /_/ /_____ | |/ /
  / __ \/ __/ __/ __ \|   /
 / / / / /_/ /_/ /_/ /   |
/_/ /_/\__/\__/ .___/_/|_|
             /_/

                projectdiscovery.io

http://154.53.32.142/.env [404]
http://154.195.41.36:7052/.env [407]
https://154.61.180.151:80/.env [200]
```
