#!/bin/sh

cd "$(dirname "$0")"
bin/ApplicationLauncher -platform linuxfb -plugin tslib:/dev/input/event1 2>/dev/null &
