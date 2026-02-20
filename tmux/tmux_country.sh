#!/bin/sh
CACHE="/tmp/.tmux_country_cache"
TTL=15

if [ -f "$CACHE" ]; then
    age=$(( $(date +%s) - $(stat -f %m "$CACHE") ))
    if [ "$age" -lt "$TTL" ]; then
        cat "$CACHE"
        exit 0
    fi
fi

data=$(curl -s --max-time 3 "https://ipwho.is/")
ip=$(echo "$data" | jq -r '.ip // empty')
country=$(echo "$data" | jq -r '.country_code // empty')

if [ -n "$ip" ] && [ -n "$country" ]; then
    printf '%s %s' "$country" "$ip" > "$CACHE"
    printf '%s %s' "$country" "$ip"
else
    [ -f "$CACHE" ] && cat "$CACHE"
fi
