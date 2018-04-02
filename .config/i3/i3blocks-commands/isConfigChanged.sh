#!/bin/sh

if [[ `git -C ~ fetch --dry-run` ]]; then
    echo "<span color='#ff5ef4'>NEW REMOTE</span>"
elif [[ `git -C ~ status --porcelain` ]]; then
    echo "<span color='#ff5ef4'>NEW LOCAL</span>"
else
   echo "OK"
fi
