#!/usr/bin/perl

use warnings;
use strict;

use File::Basename;
use Test::More;

plan tests => 8;
chdir(dirname($0));

my $firefox = `docker compose exec -T debian-xfce firefox --version 2>&1`;
is($? >> 8, 0, "Firefox executable starts");
like($firefox, qr/Mozilla Firefox \d+\./, "Firefox version is available");

my $chrome = `docker compose exec -T debian-xfce google-chrome --version 2>&1`;
is($? >> 8, 0, "Google Chrome executable starts");
like($chrome, qr/Google Chrome \d+\./, "official Google Chrome is installed");

system("docker compose exec -T debian-xfce test ! -e /dev/dri");
is($? >> 8, 0, "container has no GPU device");

system("docker", "compose", "exec", "-d", "debian-xfce", "sh", "-c", <<'SH');
exec timeout 30s /usr/bin/google-chrome-stable \
    --no-first-run --no-default-browser-check \
    --user-data-dir=/tmp/chrome-smoke-test --remote-debugging-port=9222 \
    "data:text/html,<title>VNC Chrome smoke test</title>" \
    > /tmp/chrome-smoke-test.log 2>&1
SH
is($? >> 8, 0, "launch Google Chrome on the VNC display");

my $version = "";
my $tabs = "";
for (1 .. 20) {
	$version = `docker compose exec -T debian-xfce wget -qO- http://127.0.0.1:9222/json/version 2>/dev/null`;
	$tabs = `docker compose exec -T debian-xfce wget -qO- http://127.0.0.1:9222/json/list 2>/dev/null`;
	last if $tabs =~ /"title":\s*"VNC Chrome smoke test"/;
	sleep 1;
}
like($version, qr/"Browser":\s*"Chrome\//, "Chrome starts without a GPU or headless mode");
like($tabs, qr/"title":\s*"VNC Chrome smoke test"/, "Chrome renders a page on the VNC display");
diag(`docker compose exec -T debian-xfce cat /tmp/chrome-smoke-test.log 2>&1`) unless $tabs =~ /VNC Chrome smoke test/;
