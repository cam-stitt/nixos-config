{ config, pkgs, lib, ... }:

with lib;
let
  colors = {
    base00 = "#1e1e1e";
    base01 = "#323537";
    base02 = "#464b50";
    base03 = "#5f5a60";
    base04 = "#838184";
    base05 = "#a7a7a7";
    base06 = "#c3c3c3";
    base07 = "#ffffff";
    base08 = "#cf6a4c";
    base09 = "#cda869";
    base0A = "#f9ee98";
    base0B = "#8f9d6a";
    base0C = "#afc4db";
    base0D = "#7587a6";
    base0E = "#9b859d";
    base0F = "#9b703f";
  };
  modifier = config.xsession.windowManager.i3.config.modifier;
in
{
  home.file = {
    ".config/i3blocks-contrib" = {
      recursive = true;
      source = ./i3blocks-contrib;
    };
  };

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      assigns = {
        "1: " = [{ class = "^code$"; }];
        "2: " = [{ }];
        "3: " = [{ class = "^Firefox$"; }];
        "4: " = [{ class = "^Spotify$"; }];
        "5: " = [{ class = "^discord$"; }];
        "6: " = [{ }];
        "7: " = [{ }];
        "8: " = [{ }];
        "9: " = [{ }];
        "10: " = [{ }];
      };
      fonts = {
        names = [ "Hack" ];
        size = 14.0;
      };
      colors = {
        focused = {
          border = colors.base05;
          background = colors.base0D;
          text = colors.base00;
          indicator = colors.base0D;
          childBorder = colors.base0C;
        };
        focusedInactive = {
          border = colors.base01;
          background = colors.base01;
          text = colors.base05;
          indicator = colors.base03;
          childBorder = colors.base01;
        };
        unfocused = {
          border = colors.base01;
          background = colors.base0D;
          text = colors.base05;
          indicator = colors.base01;
          childBorder = colors.base01;
        };
        urgent = {
          border = colors.base08;
          background = colors.base08;
          text = colors.base00;
          indicator = colors.base08;
          childBorder = colors.base08;
        };
        placeholder = {
          border = colors.base00;
          background = colors.base00;
          text = colors.base05;
          indicator = colors.base00;
          childBorder = colors.base00;
        };
        background = colors.base07;
      };
      bars = [
        {
          statusCommand = "i3blocks";
          position = "bottom";
          fonts = {
            names = [ "Hack" "Font Awesome" ];
            size = 14.0;
          };
          colors = {
            background = colors.base00;
            separator = colors.base01;
            statusline = colors.base04;

            focusedWorkspace = {
              border = colors.base05;
              background = colors.base0D;
              text = colors.base00;
            };
            activeWorkspace = {
              border = colors.base05;
              background = colors.base03;
              text = colors.base00;
            };
            inactiveWorkspace = {
              border = colors.base03;
              background = colors.base01;
              text = colors.base05;
            };
            urgentWorkspace = {
              border = colors.base08;
              background = colors.base08;
              text = colors.base00;
            };
            bindingMode = {
              border = colors.base00;
              background = colors.base0A;
              text = colors.base00;
            };
          };
        }
      ];
      modes = {
        resize = {
          Down = "resize grow height 10 px or 10 ppt";
          Escape = "mode default";
          Left = "resize shrink width 10 px or 10 ppt";
          Return = "mode default";
          Right = "resize grow width 10 px or 10 ppt";
          Up = "resize shrink height 10 px or 10 ppt";
          k = "resize grow height 10 px or 10 ppt";
          j = "resize shrink width 10 px or 10 ppt";
          l = "resize shrink height 10 px or 10 ppt";
          semicolon = "resize grow width 10 px or 10 ppt";
        };
      };
      keybindings = mkOptionDefault {
        "${modifier}+d" = "exec rofi -no-lazy-grab -show run";
        "${modifier}+j" = "focus left";
        "${modifier}+k" = "focus down";
        "${modifier}+l" = "focus up";
        "${modifier}+semicolon" = "focus right";
        "${modifier}+Shift+j" = "move left";
        "${modifier}+Shift+k" = "move down";
        "${modifier}+Shift+l" = "move up";
        "${modifier}+Shift+semicolon" = "move right";
      };
    };
    extraConfig = ''
      set $mod ${modifier}

      bindsym --release Caps_Lock exec pkill -SIGRTMIN+11 i3blocks
      bindsym --release Num_Lock  exec pkill -SIGRTMIN+11 i3blocks

      # Use pactl to adjust volume in PulseAudio.
      # change volume or toggle mute
      bindsym XF86AudioRaiseVolume exec amixer -q -D pulse sset Master 5%+ && pkill -RTMIN+1 i3blocks
      bindsym XF86AudioLowerVolume exec amixer -q -D pulse sset Master 5%- && pkill -RTMIN+1 i3blocks
      bindsym XF86AudioMute exec amixer -q -D pulse sset Master toggle && pkill -RTMIN+1 i3blocks

      bindsym $mod+shift+x exec i3lock --color "$base00"

      exec_always feh --bg-scale /home/cameron/Pictures/wallpaper.jpeg
      exec_always compton

      # mode for helping out emacs
      mode "passthrough" {
          bindsym $mod+Alt_R mode "default"
      }
      bindsym $mod+Alt_R mode "passthrough"
    '';
  };
}