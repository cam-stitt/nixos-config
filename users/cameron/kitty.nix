{ config, pkgs, lib, ... }: 

with lib;
{
    programs.kitty = {
        enable = true;
        darwinLaunchOptions = [
            "--single-instance"
        ];
        environment = {
            "LS_COLORS" = "0";
        };
        extraConfig = ''
        include acme.conf
        '';
        font = {
            name = "Hack Nerd Font";
            size = 14;
        };
        shellIntegration = {
            enableFishIntegration = true;
        };
        theme = null;
        settings = {
            tab_bar_style = "powerline";
            active_tab_font_style = "bold";
        };
    };
}
