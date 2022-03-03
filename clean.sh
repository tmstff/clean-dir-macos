#!/bin/bash

# example crontab 15 19 * * * /Users/tim/scripts/clean.sh dir /Users/tim/Downloads
# see also https://osxdaily.com/2020/04/27/fix-cron-permissions-macos-full-disk-access/

script=$0
type=$1
dir=$2

if [[ "$type" == "file" ]]; then
    file=$3
    mv "$file" ~/.Trash
    echo "$file" >> "$dir"/cleanedFiles
fi

if [[ "$type" == "dir" ]]; then
    date > "$dir"/lastRun
    find "$dir" -type f -ctime +90 -print0 | xargs -0 -I {} "$script" file "$dir" "{}" 
    find "$dir" -type d -empty -print0 | xargs -0 rm -rf
fi
