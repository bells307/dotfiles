#!/bin/sh
# Get current keyboard layout for macOS
layout=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources 2>/dev/null | \
    grep -E '(KeyboardLayout Name|Input Mode)' | tail -1 | sed 's/.*= //;s/;//' | xargs)

# Default if all methods fail
[ -z "$layout" ] && layout="N/A"

# Map common layouts to short codes
case "$layout" in
    *Russian*|*RU*|*Русская*) short="RU" ;;
    *U.S.*|*US*|*ABC*|*American*) short="EN" ;;
    *British*|*GB*) short="EN" ;;
    *German*|*DE*) short="DE" ;;
    *French*|*FR*) short="FR" ;;
    *Spanish*|*ES*) short="ES" ;;
    *Italian*|*IT*) short="IT" ;;
    *Chinese*|*CN*|*ZH*) short="ZH" ;;
    *Japanese*|*JP*) short="JP" ;;
    *) short="${layout}" ;;
esac

echo "#[fg=cyan]${short}"
