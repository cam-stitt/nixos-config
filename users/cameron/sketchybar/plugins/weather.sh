#!/usr/bin/env bash

WEATHER="$(curl -s 'wttr.in/Kallangur?format=%f')"

sketchybar -m --set $NAME label="$WEATHER"
