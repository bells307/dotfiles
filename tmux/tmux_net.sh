#!/bin/sh
CACHE="/tmp/.tmux_net_cache"

# Detect active network interface
iface=$(route -n get default 2>/dev/null | awk '/interface:/ {print $2}')
if [ -z "$iface" ]; then
    echo "#[fg=red]NET --"
    exit 0
fi

# Get cumulative bytes in/out (column index resolved from header)
stats=$(netstat -I "$iface" -b 2>/dev/null | awk '
    NR==1 { for(i=1;i<=NF;i++) { if($i=="Ibytes") ic=i; if($i=="Obytes") oc=i }; next }
    NR==2 { print $ic, $oc; exit }
')
cur_in=$(echo "$stats" | awk '{print $1}')
cur_out=$(echo "$stats" | awk '{print $2}')
now=$(date +%s)

if [ -z "$cur_in" ] || [ -z "$cur_out" ]; then
    echo "#[fg=red]NET --"
    exit 0
fi

fmt() {
    v=$1
    [ "$v" -ge 1048576 ] && awk "BEGIN {printf \"%.1fM\", $v / 1048576}" && return
    [ "$v" -ge 1024 ]    && awk "BEGIN {printf \"%.0fK\", $v / 1024}"    && return
    printf '%sB' "$v"
}

if [ -f "$CACHE" ]; then
    prev_in=$(awk '{print $1}' "$CACHE")
    prev_out=$(awk '{print $2}' "$CACHE")
    prev_time=$(awk '{print $3}' "$CACHE")
    elapsed=$(( now - prev_time ))

    if [ "$elapsed" -gt 0 ] && [ "$elapsed" -le 15 ] && [ "$cur_in" -ge "${prev_in:-0}" ]; then
        dl=$(( (cur_in - prev_in) / elapsed ))
        ul=$(( (cur_out - prev_out) / elapsed ))

        c="green"
        [ "$dl" -gt 1048576 ]  && c="yellow"
        [ "$dl" -gt 10485760 ] && c="red"

        printf '%s %s %s' "$cur_in" "$cur_out" "$now" > "$CACHE"
        echo "#[fg=$c]↓$(fmt "$dl") ↑$(fmt "$ul")"
        exit 0
    fi
fi

# First run or stale cache — save snapshot, show placeholder
printf '%s %s %s' "$cur_in" "$cur_out" "$now" > "$CACHE"
echo "#[fg=white]NET --"
