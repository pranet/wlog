#!/bin/sh

set -e

is_append_mode=false
default_display_limit=20
filename=$(dirname $(readlink $0))/wlog.txt	

while getopts "a" opt; do
    case $opt in
        a) is_append_mode=true;;
	?)   printf "Usage: %s: [-a] work_done \n" $0
              exit 2;;
    esac
done

if [ "$is_append_mode" = true ]; then
	echo "`date`	${*:2}" >> $filename
	display_limit=$default_display_limit
else
	display_limit=${1:-$default_display_limit}
fi

if [ -f $filename ]; then	
	tail -n $display_limit $filename
fi

