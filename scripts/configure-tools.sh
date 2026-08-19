#!/usr/bin/env bash

set -euo pipefail

echo "Requested tools: ${TOOLS}"

for tool in ${TOOLS}; do
    case "${tool}" in
        composer)
            composer --version
            ;;

        phpunit)
            if command -v phpunit >/dev/null 2>&1; then
                phpunit --version
            else
                echo "::warning::PHPUnit is not installed globally."
            fi
            ;;

        pest)
            if command -v pest >/dev/null 2>&1; then
                pest --version
            else
                echo "::warning::Pest is not installed globally."
            fi
            ;;

        *)
            echo "::warning::Unknown tool: ${tool}"
            ;;
    esac
done