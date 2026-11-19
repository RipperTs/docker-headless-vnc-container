#!/usr/bin/env bash
set -e

FF_VERSION=147.0
echo "Install Firefox $FF_VERSION"

FF_INST=/usr/lib/firefox
wget -qO /tmp/firefox.tar.xz "https://download.mozilla.org/?product=firefox-$FF_VERSION&os=linux64&lang=en-US"
mkdir -p "$FF_INST"
tar -xJf /tmp/firefox.tar.xz --strip-components=1 -C "$FF_INST"
rm /tmp/firefox.tar.xz
ln -s "$FF_INST/firefox" /usr/bin/firefox

mkdir -p "$FF_INST/distribution"
echo '{"policies": {"DisableAppUpdate": true}}' > "$FF_INST/distribution/policies.json"
