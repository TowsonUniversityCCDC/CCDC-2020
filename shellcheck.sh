#!/usr/bin/env bash
set -e
set -o pipefail

ERROR=()

for f in $(find . -type f -not -path '*.git*' | sort -u); do
    if file "$f" | grep --quiet "shell script"; then
        shellcheck --exclude=SC2086,SC2181,SC2162 -x "$f" || ERROR+=("$f")
    fi
done

if [ ${#ERROR[@]} -ne 0 ]; then
    exit 1
fi
