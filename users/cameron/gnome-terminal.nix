{ config, pkgs, lib, ... }:

with lib;
{
  programs.gnome-terminal = {
      enable = true;
      themeVariant = "light";
      profile = {
        "aaaa6352-6903-4a6a-8c1d-7f0d30618971" = {
          visibleName = "Solarized Light";
          default = false;
          allowBold = false;
          font = "Hack 14";
          colors = {
            palette = [
              "#073642"
              "#DC322F"
              "#859900"
              "#B58900"
              "#268BD2"
              "#D33682"
              "#2AA198"
              "#EEE8D5"
              "#002B36"
              "#CB4B16"
              "#586E75"
              "#657B83"
              "#839496"
              "#6C71C4"
              "#93A1A1"
              "#FDF6E3"
            ];
            backgroundColor = "#FDF6E3";
            foregroundColor = "#657B83";
            cursor = {
              foreground = "#657B83";
              background = "#657B83";
            };
            boldColor = "#586E75";
          };
        };
        "d680275a-7464-45d1-a89b-4762a730c078" = {
          visibleName = "Base16 Twilight Dark";
          default = false;
          allowBold = true;
          font = "Hack 14";
          colors = {
            palette = [
              "#1e1e1e"
              "#cf6a4c"
              "#8f9d6a"
              "#f9ee98"
              "#7587a6"
              "#9b859d"
              "#afc4db"
              "#a7a7a7"
              "#5f5a60"
              "#cf6a4c"
              "#8f9d6a"
              "#f9ee98"
              "#7587a6"
              "#9b859d"
              "#afc4db"
              "#ffffff"
            ];
            backgroundColor = "#1e1e1e";
            foregroundColor = "#a7a7a7";
            cursor = {
              foreground = "#1e1e1e";
              background = "#a7a7a7";
            };
            boldColor = null;
          };
        };
        "d790275a-7464-45d1-a89b-4762a730c078" = {
          visibleName = "Acme";
          default = true;
          allowBold = true;
          font = "Hack 14";
          colors = {
            palette = [
              "#424242"
              "#b8261e"
              "#3e8630"
              "#7f8f29"
              "#2a8dc5"
              "#8888c7"
              "#6aa7a8"
              "#999957"
              "#eeeea7"
              "#f2acaa"
              "#98ce8f"
              "#b6b79c"
              "#a6dcf8"
              "#d0d1f7"
              "#b0eced"
              "#ffffec"
            ];
            backgroundColor = "#ffffec";
            foregroundColor = "#000000";
            cursor = {
              background = "#000000";
              foreground = "#ffffec";
            };
            boldColor = null;
          };
        };
      };
    };
}
