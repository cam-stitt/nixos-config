#!/bin/sh

source "$CONFIG_DIR/colors.sh"

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

if [ "$SELECTED" = true ]; then
  sketchybar --set $NAME icon.color=$PURPLE
else
  sketchybar --set $NAME icon.color=$BLACK
fi
