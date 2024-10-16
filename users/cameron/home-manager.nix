{ isWSL, inputs, ... }:

{ config, lib, pkgs, ... }:

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
    ./fish.nix
    ./git.nix
    ./emacs.nix
    ./kitty.nix
    (
      import ./i3.nix (
        { isWSL = isWSL; isLinux = isLinux; }
      )
    )
    (
      import ./rofi.nix (
        { isWSL = isWSL; isLinux = isLinux; }
      )
    )
  ];

  # Home-manager 22.11 requires this be set. We never set it so we have
  # to use the old state version.
  home.stateVersion = "18.09";

  home.packages = [
    pkgs.jq
    pkgs.go
    pkgs.gopls
    pkgs.delve
    pkgs.gh

    pkgs.hack-font
    pkgs.nerdfonts
    pkgs.font-awesome
  ] ++ (lib.optionals (isLinux && !isWSL) [
    pkgs.firefox
    pkgs._1password
    pkgs.i3blocks
    pkgs.arandr
    pkgs.feh
    pkgs.ngrok
  ]);

  home.sessionVariables = {
    EDITOR = "emacsclient -t";
    VISUAL = "emacsclient -c";
  };

  programs.vscode = {
    enable = isLinux && !isWSL;
  };

  programs.gpg = {
    enable = isLinux && !isWSL;

    settings = {
      keyid-format = "LONG";
    };
  };

  services.gpg-agent = {
    enable = isLinux && !isWSL;
    pinentryPackage = pkgs.pinentry-tty;
    enableSshSupport = true;
    defaultCacheTtl = 31536000;
    maxCacheTtl = 31536000;
  };

  # Make cursor not tiny on HiDPI screens
  home.pointerCursor = lib.mkIf (isLinux && !isWSL) {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
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
          "$HOME/code"
        ];

        exact = ["$HOME/.envrc"];
      };
    };
  };

  home.file = {
    ".config/kitty" = {
      enable = true;
      recursive = true;
      source = ./kitty;
    };
    ".yabairc" = {
      enable = isDarwin;
      source = ./yabai/.yabairc;
      executable = true;
    };
    ".skhdrc" = {
      enable = isDarwin;
      source = ./skhd/.skhdrc;
      executable = true;
    };
    ".config/sketchybar" = {
      enable = false;
      source = ./sketchybar;
      recursive = true;
      executable = true;
    };
    ".config/i3blocks" = {
      enable = (isLinux && !isWSL);
      recursive = true;
      source = ./i3blocks;
    };
  };

  # required for vscode authentication
  services.gnome-keyring = {
    enable = (isLinux && !isWSL);
    components = [ "pkcs11" "secrets" "ssh" ];
  };
}
