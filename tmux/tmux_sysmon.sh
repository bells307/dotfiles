#!/bin/sh
info=$(top -l 1 -s 0 -n 0)

cpu=$(echo "$info" | awk 'tolower($0) ~ /cpu usage/ {
    for (i = 1; i <= NF; i++)
        if ($i == "idle") { v = $(i-1); gsub(/[^0-9.]/, "", v); break }
    printf "%.0f", 100 - v
}')
cpu_c="green"
[ "${cpu:-0}" -gt 40 ] && cpu_c="yellow"
[ "${cpu:-0}" -gt 70 ] && cpu_c="red"

to_gb() {
    n=$(printf '%s' "$1" | sed 's/[^0-9.]//g')
    s=$(printf '%s' "$1" | grep -oE '[GMgm]' | head -1)
    if [ "$s" = "M" ]; then
        awk "BEGIN {printf \"%.1f\", $n / 1024}"
    else
        printf '%s' "$n"
    fi
}

phys=$(echo "$info" | grep "PhysMem:")
used_raw=$(echo "$phys" | awk '{print $2}')
unused_raw=$(echo "$phys" | awk '{for(i=1;i<=NF;i++) if($i=="unused.") print $(i-1)}')

used=$(to_gb "$used_raw")
unused=$(to_gb "$unused_raw")
total=$(awk "BEGIN {printf \"%.1f\", $used + $unused}")
ram_pct=$(awk "BEGIN {printf \"%.0f\", 100 * $used / ($used + $unused)}")

ram_c="green"
[ "${ram_pct:-0}" -gt 60 ] && ram_c="yellow"
[ "${ram_pct:-0}" -gt 80 ] && ram_c="red"

echo "#[fg=$cpu_c]CPU ${cpu}% #[fg=white]| #[fg=$ram_c]RAM ${ram_pct}%"
