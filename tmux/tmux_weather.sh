#!/bin/sh
CACHE="/tmp/.tmux_weather_cache"
TTL=300

location=$(tmux show-option -gv @weather_location 2>/dev/null | tr -d ' "')
location="${location:-Moscow}"

if [ -f "$CACHE" ]; then
    age=$(( $(date +%s) - $(stat -f %m "$CACHE") ))
    if [ "$age" -lt "$TTL" ]; then
        cat "$CACHE"
        exit 0
    fi
fi

# format="%t"
format="%t(%f)"
result=$(curl -s --max-time 10 "https://wttr.in/${location}?format=$format" | sed 's/\xef\xb8\x8f//g' | sed 's/\(.*\)°C(\(.*\)°C)/\1(\2)°C/')

if [ -n "$result" ]; then
    printf '%s' "$result" > "$CACHE"
    printf '%s' "$result"
else
    [ -f "$CACHE" ] && cat "$CACHE"
fi
