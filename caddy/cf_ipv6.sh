#!/usr/bin/env sh
# Got this from https://blog.alexsguardian.net/posts/2023/12/04/caddyguide-part1
# Updated by https://github.com/vogelbirb to simply print out Cloudflare IPs, because I'm too lazy to setup a cron job.
#
# This script queries cloudflare's website and pulls the list of IPv6 addresses. They are then loaded into a file to be used by Caddy.
# These IPs can be used for setting up trusted proxy configurations in web servers.
# Original file creator: https://caddy.community/t/trusted-proxies-with-cloudflare-my-solution/16124
# Updated by https://github.com/calvinhenderson to be more "succinct" as he put it. :)

tmp_file="/var/tmp/cloudflare-ips-v6-$(date +%Y%m%d_%H%M%S)"

# Make sure curl exists
command -v curl >/dev/null || { echo "Command 'curl' was not found. Is it in the PATH?"; exit 1; }

# Fetch the IP list from Cloudflare
curl -fso "$tmp_file" "https://www.cloudflare.com/ips-v6"
[ $? -eq 0 ] || { echo "Failed to fetch IPv6 list."; exit 1; }

# Transform the downloaded list into a format Caddy can understand
awk -v d=" " '{s=(NR==1?s:s d)$0}END{print "trusted_proxies "s}' "$tmp_file"

# Clean up
rm -f "$tmp_file"
