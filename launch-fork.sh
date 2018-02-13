#!/bin/sh

. /opt/ApplicationLauncher/demo.config

# close stdout, stderr, stdin and double fork - it's magic
(($@ >&- 2>&- <&- &)&)
