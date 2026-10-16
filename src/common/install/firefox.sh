#!/usr/bin/env bash
set -e

echo "Install latest stable Firefox"

case "$(uname -m)" in
    x86_64) FF_OS=linux64 ;;
    aarch64) FF_OS=linux64-aarch64 ;;
    *) echo "Unsupported Firefox architecture: $(uname -m)" >&2; exit 1 ;;
esac

FF_INST=/usr/lib/firefox
wget -qO /tmp/firefox.tar.xz "https://download.mozilla.org/?product=firefox-latest-ssl&os=$FF_OS&lang=en-US"
mkdir -p "$FF_INST"
tar -xJf /tmp/firefox.tar.xz --strip-components=1 -C "$FF_INST"
rm /tmp/firefox.tar.xz
ln -s "$FF_INST/firefox" /usr/bin/firefox

