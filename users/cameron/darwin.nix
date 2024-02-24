{ inputs, pkgs, ... }:

let
  emacsPkg = ( pkgs.emacs.overrideAttrs (oldAttrs: {
    configureFlags = oldAttrs.configureFlags ++
      [ "--without-toolkit-scroll-bars" "--with-x-toolkit=yes" ];
    buildInputs = oldAttrs.buildInputs ++
      [ pkgs.gtk3.dev ];
  }));
in
{
  users.users.cameronstitt = {
    home = "/Users/cameronstitt";
    shell = pkgs.fish;
    name = "cameronstitt";
  };

  services.emacs = {
    enable = true;
    package = emacsPkg;
  };

  services.sketchybar = {
    enable = false;
  };

  homebrew = {
    enable = true;
    brews = [
      {
        name = "koekeishiya/formulae/yabai";
      }

      {
        name = "koekeishiya/formulae/skhd";
      }

      {
        name = "redis";
        restart_service = true;
      }

      {
        name = "switchaudio-osx";
      }

      {
        name = "hashicorp/security/doormat-cli";
      }

      {
        name = "hashicorp/tap/nomad";
      }

      {
        name = "hashicorp/internal/tfcdev";
      }
      
    ];

    taps = [
      {
        name = "hashicorp/security";
        clone_target = "git@github.com:hashicorp/homebrew-security.git";
      }

      {
        name = "hashicorp/tap";
        clone_target = "https://github.com/hashicorp/homebrew-tap";
      }

      {
        name = "hashicorp/internal";
        clone_target = "git@github.com:hashicorp/homebrew-internal.git";
      }
    ];

    casks = [
      "visual-studio-code"
      "hammerspoon"
      "postman"
      "google-chrome"
      "docker"
    ];
  };
}
