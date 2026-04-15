#!/usr/bin/env bash
set -euo pipefail

CF_URL="https://api.cloudflare.com/client/v4/ips"
ACL_FILE="/etc/haproxy/cloudflare.acl"
TMP_FILE=$(mktemp)

echo "# Cloudflare IP ranges - generated on $(date)" > "$TMP_FILE"

curl -s "$CF_URL" | jq -r '.result.ipv4[], .result.ipv6[]' >> "$TMP_FILE"

mv "$TMP_FILE" "$ACL_FILE"

systemctl reload haproxy

echo "Zaktualizowano listę IP Cloudflare i przeładowano HAProxy."
