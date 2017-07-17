#!/bin/bash
set -euxo pipefail

mkdir -p /data
[ ! -f /data/root.zone ] && cat > /data/root.zone <<'EOL'
@ IN SOA . dnsadmin.example.net. (
 2009092001 ; Serial
 604800     ; Refresh
 86400      ; Retry
 1206900    ; Expire
 300 )      ; Negative Cache TTL
   IN NS ns1.example.net.
*. IN A  127.0.0.1
EOL

chown -R bind:bind /data/*
exec /usr/sbin/named -g -u bind
