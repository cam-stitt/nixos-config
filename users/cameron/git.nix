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
    extraConfig = {
      core = {
        editor = "nvim";
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