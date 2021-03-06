#!/bin/bash
set -euxo pipefail

mkdir -p /data/log

[ ! -f /data/zone.conf ] && touch /data/zone.conf

[ ! -f /data/root.zone ] && cat > /data/root.zone <<'EOL'
$TTL 600
@ IN SOA . dnsadmin.example.net. (
 2017010101 ; Serial
 604800     ; Refresh
 86400      ; Retry
 1206900    ; Expire
 600 )      ; Negative Cache TTL
   IN NS   ns1.example.net.
*. IN A    127.0.0.1
*. IN AAAA ::1

EOL

chown -R bind:bind /data
exec /usr/sbin/named -4 -f -u bind
