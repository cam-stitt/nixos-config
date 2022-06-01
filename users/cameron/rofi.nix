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
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  programs.rofi = {
    enable = true;
    cycle = true;
    font = "Hack 12";
    extraConfig = {
      modi = "run,drun,window";
      fixed-num-lines = true;
      show-icons = false;
      eh = 2;
      scroll-method = 0;
      window-format = "[{w}] ··· {c} ···   {t}";
      click-to-exit = true;
      combi-hide-mode-prefix = false;
      display-window = "";
      display-windowcd = "";
      display-run = "";
      display-ssh = "";
      display-drun = "";
      display-combi = "";
    };
    theme = ./theme.rasi;
  };
}