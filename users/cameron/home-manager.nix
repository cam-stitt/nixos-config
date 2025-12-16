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
  ] ++ (lib.optionals (!isWSL) [
    ./emacs.nix
  ]);

  # Home-manager 22.11 requires this be set. We never set it so we have
  # to use the old state version.
  home.stateVersion = "18.09";

  xdg.enable = true;

  home.packages = [
    pkgs.jq
    pkgs.go
    pkgs.gopls
    pkgs.delve
    pkgs.gh
    pkgs.libgccjit

    pkgs.hack-font
    pkgs.font-awesome
    pkgs.devbox
    pkgs.wget
  ] ++ (lib.optionals (isLinux && !isWSL) [
    pkgs.rofi
    pkgs.firefox
    pkgs._1password
    pkgs.i3blocks
    pkgs.arandr
    pkgs.feh
    pkgs.ngrok
    pkgs.pgadmin4
  ]) ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  home.sessionVariables = {
    EDITOR = "emacsclient -t";
    VISUAL = "emacsclient -c";
  };

  programs.vscode = {
    enable = isLinux && !isWSL;
  };

  programs.gpg = {
    enable = isLinux;

    settings = {
      keyid-format = "LONG";
    };
  };

  services.gpg-agent = {
    enable = isLinux;
    pinentry.package = pkgs.pinentry-tty;
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

  programs.kitty = {
      enable = true;
      darwinLaunchOptions = [
          "--single-instance"
      ];
      environment = {
      };
      extraConfig = builtins.readFile ./kitty;
      shellIntegration = {
          enableFishIntegration = true;
      };
  };

  # xsession.windowManager.i3 = {
  #   enable = (isLinux && !isWSL);
  # };

  home.file = {
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
    ".config/i3blocks" = {
      enable = (isLinux && !isWSL);
      recursive = true;
      source = ./i3blocks;
    };
    ".config/i3blocks-contrib" = {
      recursive = true;
      source = ./i3blocks-contrib;
      enable = (isLinux && !isWSL);
    };
  };

  xdg.configFile = {
    "i3/config".text = builtins.readFile ./i3;
    "rofi/config.rasi".text = builtins.readFile ./rofi;
  };

  # required for vscode authentication
  services.gnome-keyring = {
    enable = (isLinux && !isWSL);
    components = [ "pkcs11" "secrets" "ssh" ];
  };
}
