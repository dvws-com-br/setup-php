#!/usr/bin/env bash

set -euo pipefail

ini_dir="$(
    php --ini |
        awk -F': ' '/Scan for additional .ini files in:/ {gsub(/"/, "", $2); print $2}'
)"

if [[ -z "${ini_dir}" || ! -d "${ini_dir}" ]]; then
    echo "::error::PHP additional INI directory not found."
    php --ini
    exit 1
fi

ini_file="${ini_dir}/99-custom.ini"

printf '%s\n' "${INI_VALUES}" |
    sudo tee "${ini_file}" > /dev/null

echo "Custom PHP INI:"
echo "File: ${ini_file}"

cat "${ini_file}"
