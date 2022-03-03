#!/bin/bash

# example crontab 15 19 * * * /Users/tim/scripts/clean.sh dir /Users/tim/Downloads

script=$0
type=$1
dir=$2

if [[ "$type" == "file" ]]; then
    file=$3
    mv "$file" ~/.Trash
    echo "$file" >> "$2"/cleanedFiles
fi

if [[ "$type" == "dir" ]]; then
    date > "$dir"/lastRun
    find "$dir" -type f -ctime +90 -print0 | xargs -0 -I {} "$script" file "$dir" "{}" 
    find "$dir" -type d -empty -print0 | xargs -0 rm -rf
fi
