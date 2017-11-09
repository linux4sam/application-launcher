#!/bin/sh

# close stdout, stderr, stdin and double fork - it's magic
(($@ >&- 2>&- <&- &)&)
