#!/bin/bash

volume_slider=(
  script="$PLUGIN_DIR/volume.sh"
  updates=on
  label.drawing=off
  icon.drawing=off
  slider.highlight_color=$PURPLE
  slider.background.height=5
  slider.background.corner_radius=3
  slider.background.color=$LAVENDER
  slider.knob=
  slider.knob.drawing=on
)

volume_icon=(
  click_script="$PLUGIN_DIR/volume_click.sh"
  padding_left=10
  icon=$VOLUME_90
  icon.align=left
  icon.color=$BLACK
  icon.font="$FONT:Bold:17.0"
  label.align=left
  label.font="$FONT:Bold:14.0"
)

sketchybar --add slider volume right            \
           --set volume "${volume_slider[@]}"   \
           --subscribe volume volume_change     \
                              mouse.clicked     \
                                                \
           --add item volume_icon right         \
           --set volume_icon "${volume_icon[@]}"
