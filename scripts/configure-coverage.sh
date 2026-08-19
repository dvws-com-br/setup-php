#!/usr/bin/env bash

set -euo pipefail

coverage="${COVERAGE}"

ini_dir="$(
    php --ini |
        awk -F': ' '/Scan for additional .ini files in:/ {gsub(/"/, "", $2); print $2}'
)"

if [[ -z "${ini_dir}" || ! -d "${ini_dir}" ]]; then
    echo "::error::PHP additional INI directory not found."
    php --ini
    exit 1
fi

ini_file="${ini_dir}/99-coverage.ini"

case "${coverage}" in
    pcov)
        {
            echo "pcov.enabled=1"
            echo "pcov.directory=${GITHUB_WORKSPACE}"
        } | sudo tee "${ini_file}" > /dev/null

        echo "PCOV coverage enabled."
        ;;

    xdebug)
        {
            echo "xdebug.mode=coverage"
            echo "xdebug.start_with_request=no"
        } | sudo tee "${ini_file}" > /dev/null

        echo "Xdebug coverage enabled."
        ;;

    *)
        echo "::error::Unsupported coverage driver: ${coverage}"
        echo "::error::Supported values: pcov, xdebug"
        exit 1
        ;;
esac

echo "Configuration: ${ini_file}"
cat "${ini_file}"
