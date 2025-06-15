#!/usr/bin/env bash
layout=$(hyprctl devices -j | jq -r '
  .keyboards[] | select(.main == true) | .active_keymap
')

echo "⌨️ $layout"
