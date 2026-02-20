#!/bin/sh
pct=$(pmset -g batt | grep -oE '[0-9]+%' | head -1 | tr -d '%')
[ -z "$pct" ] && exit 0

c=red
[ "$pct" -gt 20 ] && c=yellow
[ "$pct" -gt 50 ] && c=green

pmset -g batt | grep -q discharging && s="BAT" || s="AC"

echo "#[fg=$c]$s ${pct}%"
