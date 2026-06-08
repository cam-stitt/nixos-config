{ config, pkgs, lib, ... }:

with lib;
{
  programs.delta = {
    enable = true;
    options = {
      navigate = true;
      light = false;
      line-numbers = true;
      syntax-theme = "gruvbox-light";
    };
  };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    settings = {
      user = {
        name = "Cameron Stitt";
        email = "cameron@cam.st";
      };
      aliases = {
        glog = "log --graph";
        undo = "reset --soft HEAD^";
        prune = "fetch --prune";
      };
      branch.autosetuprebase = "always";
      core.askPass = ""; # needs to be empty to use terminal for ask pass
      credential.helper = "store"; # want to make this more secure
      push.default = "tracking";
      commit.gpgsign = true;
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
      color.ui = true;
      github.user = "cam-stitt";
      init.defaultBranch = "main";
    };
    signing = {
      key = "CBCD419CDB0EB092";
      signByDefault = true;
    };
  };
}
