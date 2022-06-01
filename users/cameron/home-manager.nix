{ config, pkgs, ... }:

{
  imports = [
    ./tmux.nix
    ./gnome-terminal.nix
    ./fish.nix
    ./git.nix
    ./i3.nix
    ./rofi.nix
    #./vscode-server.nix
  ];

  home.packages = [
    pkgs.firefox
    pkgs._1password
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "cameron";
  home.homeDirectory = "/home/cameron";

  programs.neovim = {
    enable = true;
  };

  programs.vscode = {
    enable = true;
  };

  programs.gpg = {
    enable = true;

    settings = {
      keyid-format = "LONG";
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "tty";
    enableSshSupport = true;
    defaultCacheTtl = 31536000;
    maxCacheTtl = 31536000;
  };

  # Make cursor not tiny on HiDPI screens
  xsession.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 64;
  };

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
      # optional for nix flakes support in home-manager 21.11, not required in home-manager unstable or 22.05
      enableFlakes = true;
    };

    config = {
      whitelist = {
        prefix = [
          "$HOME/projects/hashicorp"
          "$HOME/projects/cam-stitt"
        ];

        exact = ["$HOME/.envrc"];
      };
    };
  };

  home.file = {
    ".config/i3blocks" = {
      recursive = true;
      source = ./i3blocks;
    };
  };

  # required for vscode authentication
  services.gnome-keyring = {
    enable = true;
    components = [ "pkcs11" "secrets" "ssh" ];
  };
}