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
        name = "bass";
        src = pkgs.fetchFromGitHub {
          owner = "edc";
          repo = "bass";
          rev = "v1.0";
          sha256 = "XpB8u2CcX7jkd+FT3AYJtGwBtmNcLXtfMyT/z7gfyQw=";
        };
      }
      # {
      #   name = "fish-ssh-agent";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "danhper";
      #     repo = "fish-ssh-agent";
      #     rev = "fd70a2a";
      #     sha256 = "1fvl23y9lylj4nz6k7yfja6v9jlsg8jffs2m5mq0ql4ja5vi5pkv";
      #   };
      # }
    ];
    shellInit = ''
      set -xg TERM "xterm-256color"
      set -xg GPG_TTY (tty)

      alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

      fish_add_path $HOME/op $HOME/go/bin

      eval (direnv hook fish)

      fish_add_path $HOME/.local/bin

      #-------------------------------------------------------------------------------
      # SSH Agent
      #-------------------------------------------------------------------------------
      function __ssh_agent_is_started -d "check if ssh agent is already started"
        if begin; test -f $SSH_ENV; and test -z "$SSH_AGENT_PID"; end
          source $SSH_ENV > /dev/null
        end

        if test -z "$SSH_AGENT_PID"
          return 1
        end

        ssh-add -l > /dev/null 2>&1
        if test $status -eq 2
          return 1
        end
      end

      function __ssh_agent_start -d "start a new ssh agent"
        ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
        chmod 600 $SSH_ENV
        source $SSH_ENV > /dev/null
        ssh-add
      end

      if not test -d $HOME/.ssh
          mkdir -p $HOME/.ssh
          chmod 0700 $HOME/.ssh
      end

      if test -d $HOME/.gnupg
          chmod 0700 $HOME/.gnupg
      end

      if test -z "$SSH_ENV"
          set -xg SSH_ENV $HOME/.ssh/environment
      end

      #if not __ssh_agent_is_started
      #    __ssh_agent_start
      #end

      #-------------------------------------------------------------------------------
      # Kitty Terminal
      #-------------------------------------------------------------------------------

      if set -q $KITTY_INSTALLATION_DIR
        kitty +kitten themes Acme
      end

      if test -e ~/.config/fish/local.fish
        source ~/.config/fish/local.fish
      end
    '';
  };
}
