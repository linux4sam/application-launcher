#!/bin/bash
# launch.sh - kills ApplicationLauncher and execs the given args, restarts launcher
# when eval returns.

eval "$@"
/opt/ApplicationLauncher/ApplicationLauncher.sh
