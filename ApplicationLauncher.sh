#!/bin/sh

cd "$(dirname "$0")"
bin/ApplicationLauncher -platform linuxfb 2>/dev/null &
