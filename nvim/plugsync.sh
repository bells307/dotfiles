#!/bin/sh
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGINS_FILE="${1:-$SCRIPT_DIR/plugins.txt}"
PACK_DIR="$HOME/.local/share/nvim/site/pack/plugins/start"

mkdir -p "$PACK_DIR"

if [ ! -f "$PLUGINS_FILE" ]; then
    echo "Error: plugins file not found: $PLUGINS_FILE" >&2
    exit 1
fi

expected=""

while IFS= read -r line || [ -n "$line" ]; do
    case "$line" in '#'* | '') continue ;; esac

    # Split fields: repo [dir] [branch] [build_cmd...]
    set -- $line
    repo="$1"
    dir="${2:--}"
    branch="${3:--}"
    build=""
    [ "$#" -ge 4 ] && {
        shift 3
        build="$*"
    }

    [ "$dir" = "-" ] && dir="${repo##*/}"
    [ "$branch" = "-" ] && branch=""
    [ "$build" = "-" ] && build=""

    expected="$expected $dir"

    if [ -d "$PACK_DIR/$dir" ]; then
        echo "Updating $dir..."
        git -C "$PACK_DIR/$dir" pull --ff-only
    else
        echo "Installing $dir..."
        if [ -n "$branch" ]; then
            git clone --depth=1 --branch "$branch" "https://github.com/$repo" "$PACK_DIR/$dir"
        else
            git clone --depth=1 "https://github.com/$repo" "$PACK_DIR/$dir"
        fi
        if [ -n "$build" ]; then
            echo "Building $dir..."
            sh -c "cd '$PACK_DIR/$dir' && $build"
        fi
    fi
done <"$PLUGINS_FILE"

# Remove plugins not in the list
for dir_path in "$PACK_DIR"/*/; do
    [ -d "$dir_path" ] || continue
    name="${dir_path%/}"
    name="${name##*/}"
    case " $expected " in
    *" $name "*) ;;
    *)
        echo "Removing $name (not in plugins list)..."
        rm -rf "$dir_path"
        ;;
    esac
done

echo ""
echo "Sync complete."
