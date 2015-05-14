#!/bin/sh
# launch.sh - kills ApplicationLauncher and execs the given args, restarts launcher
# when eval returns.

eval "$@"

resolution=`fbset | grep mode | awk -F '"' '{print $2}' | awk -F "-" '{print $1}'`

case "$resolution" in
	"480x272")
	 	/opt/ApplicationLauncher/ApplicationLauncher-small.sh
	;;
	*)
		/opt/ApplicationLauncher/ApplicationLauncher.sh
	;;
esac
