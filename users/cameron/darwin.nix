{ inputs, pkgs, ... }:

{
  users.users.cameronstitt = {
    home = "/Users/cameronstitt";
    shell = pkgs.fish;
    name = "cameronstitt";
  };

  services.emacs = {
    enable = true;
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
        name = "hashicorp/tap/vault";
      }

      {
        name = "hashicorp/tap/terraform";
      }

      {
        name = "hashicorp/internal/tfcdev";
      }

      {
        name = "python";
      }

      {
        name = "python-tk";
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
      "pgadmin4"
    ];
  };

  # Required for some settings like homebrew to know what user to apply to.
  system.primaryUser = "cameronstitt";
}
