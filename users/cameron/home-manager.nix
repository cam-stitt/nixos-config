{ config, pkgs, ... }:

let
  sources = import ../../nix/sources.nix;
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;

  # For our MANPAGER env var
  # https://github.com/sharkdp/bat/issues/1145
  manpager = (pkgs.writeShellScriptBin "manpager" (if isDarwin then ''
    sh -c 'col -bx | bat -l man -p'
    '' else ''
    cat "$1" | col -bx | bat --language man --style plain
  ''));
in {
  imports = [
    ./tmux.nix
    ./gnome-terminal.nix
    ./fish.nix
    ./git.nix
    ./i3.nix
    ./rofi.nix
    ./emacs.nix
    #./vscode-server.nix
  ];

  # Home-manager 22.11 requires this be set. We never set it so we have
  # to use the old state version.
  home.stateVersion = "18.09";

  home.packages = [
    pkgs.firefox
    pkgs._1password
    pkgs.i3blocks
    pkgs.arandr
    pkgs.feh
    pkgs.qdirstat

    pkgs.plantuml
    pkgs.graphviz
    pkgs.jre8

    pkgs.unstable.obsidian

    pkgs.rustup

    pkgs.python3
    pkgs.nodejs-16_x
    pkgs.ejson
    pkgs.jq
    pkgs.go
    pkgs.gopls
    pkgs.delve
    pkgs.docker-compose
    pkgs.docker-buildx
    pkgs.lsof
    pkgs.gcc
    pkgs.binutils
    pkgs.zip
    pkgs.unzip
    pkgs.delve
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "cameron";
  home.homeDirectory = "/home/cameron";

  home.sessionVariables = {
    EDITOR = "emacsclient -t";
    VISUAL = "emacsclient -c";
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
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 64;
    x11.enable = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-light";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };

    config = {
      whitelist = {
        prefix = [
          "$HOME/code/hashicorp"
          "$HOME/code/cam-stitt"
          "$HOME/code/openpixel"
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
