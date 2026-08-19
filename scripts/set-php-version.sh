#!/usr/bin/env bash

set -euo pipefail

version="${PHP_VERSION}"

php_binary="/usr/bin/php${version}"
phpize_binary="/usr/bin/phpize${version}"
php_config_binary="/usr/bin/php-config${version}"

if [[ ! -x "${php_binary}" ]]; then
    echo "::error::PHP ${version} is not installed."
    exit 1
fi

if [[ ! -x "${phpize_binary}" ]]; then
    echo "::error::phpize for PHP ${version} is not installed."
    exit 1
fi

if [[ ! -x "${php_config_binary}" ]]; then
    echo "::error::php-config for PHP ${version} is not installed."
    exit 1
fi

sudo update-alternatives --set php "${php_binary}"
sudo update-alternatives --set phpize "${phpize_binary}"
sudo update-alternatives --set php-config "${php_config_binary}"

echo "PHP:"
php --version

echo "PHPize:"
phpize --version

echo "PHP-config:"
php-config --version