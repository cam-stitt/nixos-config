{ config, pkgs, lib, ... }:

with lib;
{
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "pure";
        src = pkgs.fetchFromGitHub {
          owner = "rafaelrinaldi";
          repo = "pure";
          rev = "v3.5.0";
          sha256 = "134sz3f98gb6z2vgd5kkm6dd8pka5gijk843c32s616w35y07sga";
        };
      }
      {
        name = "fish-ssh-agent";
        src = pkgs.fetchFromGitHub {
          owner = "danhper";
          repo = "fish-ssh-agent";
          rev = "fd70a2a";
          sha256 = "1fvl23y9lylj4nz6k7yfja6v9jlsg8jffs2m5mq0ql4ja5vi5pkv";
        };
      }
    ];
    shellInit = ''
      set -xg TERM "xterm-256color"
      set -xg GPG_TTY (tty)

      alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

      fish_add_path $HOME/op $HOME/go/bin

      eval (direnv hook fish)

      fish_add_path $HOME/.local/bin

      # Base16 Shell
      if status --is-interactive
        set BASE16_SHELL "$HOME/.config/base16-shell/"
        source "$BASE16_SHELL/profile_helper.fish"
      end

      source ~/.config/fish/local.fish
    '';
  };
}