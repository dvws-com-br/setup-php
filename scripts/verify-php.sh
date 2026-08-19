#!/usr/bin/env bash

set -euo pipefail

echo "=============================="
echo "PHP VERSION"
echo "=============================="

php --version

echo
echo "=============================="
echo "PHP INI"
echo "=============================="

php --ini

echo
echo "=============================="
echo "PHP EXTENSIONS"
echo "=============================="

php -m

case "${COVERAGE}" in
    pcov)
        echo
        echo "=============================="
        echo "PCOV"
        echo "=============================="

        php --ri pcov
        ;;

    xdebug)
        echo
        echo "=============================="
        echo "XDEBUG"
        echo "=============================="

        php --ri xdebug
        ;;
esac