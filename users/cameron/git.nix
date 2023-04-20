{ config, pkgs, lib, ... }:

with lib;
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Cameron Stitt";
    userEmail = "cameron@cam.st";
    signing = {
      key = "CBCD419CDB0EB092";
      signByDefault = true;
    };
    aliases = {
      glog = "log --graph";
      undo = "reset --soft HEAD^";
      prune = "fetch --prune";
    };
    delta = {
      enable = true;
      options = {
        navigate = true;
        light = false;
        line-numbers = true;
        syntax-theme = "gruvbox-light";
      };
    };
    extraConfig = {
      core = {
        editor = "emacsclient -t";
      };
      commit.gpgsign = true;
      core.askPass = "";
      credential.helper = "/etc/profiles/per-user/cameron/bin/git-credential-libsecret";
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
      color.ui = true;
      github.user = "cam-stitt";
      init.defaultBranch = "main";
    };
  };
}
