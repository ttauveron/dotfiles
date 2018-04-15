#!/bin/sh

if [[ `git -C ~ fetch --dry-run` ]]; then
    echo "<span color='#ff5ef4'>NEW REMOTE</span>"
elif [[ `git -C ~ status --porcelain` ]]; then
    echo "<span color='#ff5ef4'>NEW LOCAL</span>"
elif [ "$(git rev-parse master)" != "$(git rev-parse origin/master)" ]; then
    echo "<span color='#ffff00'>TO BE PUSHED</span>"
else
   echo "OK"
fi
