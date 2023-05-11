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
  workspaces = {
    one   = "1: ";
    two   = "2: ";
    three = "3: ";
    four  = "4: ";
    five  = "5: ";
    six   = "6: ";
    seven = "7: ";
    eight = "8: " ;
    nine  = "9: ";
    ten   = "10: ";
  };
  modifier = "Mod1";
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
      modifier = modifier;
      assigns = {
        "${workspaces.one}" = [{ class = "^code$"; }];
        "${workspaces.three}" = [{ class = "^Firefox$"; }];
        "${workspaces.four}" = [{ class = "^Spotify$"; }];
        "${workspaces.five}" = [{ class = "^discord$"; }];
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
        passthrough = {
          "${modifier}+Shift+p" = "mode \"default\"";
        };
      };
      keybindings = mkOptionDefault {
        "${modifier}+Shift+p" = "mode \"passthrough\"";
        "${modifier}+d" = "exec rofi -no-lazy-grab -show run";
        "${modifier}+j" = "focus left";
        "${modifier}+k" = "focus down";
        "${modifier}+l" = "focus up";
        "${modifier}+semicolon" = "focus right";
        "${modifier}+Shift+j" = "move left";
        "${modifier}+Shift+k" = "move down";
        "${modifier}+Shift+l" = "move up";
        "${modifier}+Shift+semicolon" = "move right";

        "${modifier}+1" = "workspace ${workspaces.one}";
        "${modifier}+2" = "workspace ${workspaces.two}";
        "${modifier}+3" = "workspace ${workspaces.three}";
        "${modifier}+4" = "workspace ${workspaces.four}";
        "${modifier}+5" = "workspace ${workspaces.five}";
        "${modifier}+6" = "workspace ${workspaces.six}";
        "${modifier}+7" = "workspace ${workspaces.seven}";
        "${modifier}+8" = "workspace ${workspaces.eight}";
        "${modifier}+9" = "workspace ${workspaces.nine}";
        "${modifier}+0" = "workspace ${workspaces.ten}";

        "${modifier}+Shift+1" = "move container to workspace ${workspaces.one}";
        "${modifier}+Shift+2" = "move container to workspace ${workspaces.two}";
        "${modifier}+Shift+3" = "move container to workspace ${workspaces.three}";
        "${modifier}+Shift+4" = "move container to workspace ${workspaces.four}";
        "${modifier}+Shift+5" = "move container to workspace ${workspaces.five}";
        "${modifier}+Shift+6" = "move container to workspace ${workspaces.six}";
        "${modifier}+Shift+7" = "move container to workspace ${workspaces.seven}";
        "${modifier}+Shift+8" = "move container to workspace ${workspaces.eight}";
        "${modifier}+Shift+9" = "move container to workspace ${workspaces.nine}";
        "${modifier}+Shift+0" = "move container to workspace ${workspaces.ten}";
      };
    };
    extraConfig = ''
      bindsym --release Caps_Lock exec pkill -SIGRTMIN+11 i3blocks
      bindsym --release Num_Lock  exec pkill -SIGRTMIN+11 i3blocks

      # Use pactl to adjust volume in PulseAudio.
      # change volume or toggle mute
      bindsym XF86AudioRaiseVolume exec amixer -q -D pulse sset Master 5%+ && pkill -RTMIN+1 i3blocks
      bindsym XF86AudioLowerVolume exec amixer -q -D pulse sset Master 5%- && pkill -RTMIN+1 i3blocks
      bindsym XF86AudioMute exec amixer -q -D pulse sset Master toggle && pkill -RTMIN+1 i3blocks

      bindsym ${modifier}+shift+x exec i3lock --color "$base00"

      exec_always feh --bg-fill /home/cameron/Pictures/wallpaper.jpeg
    '';
  };
}
