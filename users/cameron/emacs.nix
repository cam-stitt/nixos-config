{ pkgs, lib, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  programs.emacs = {
    enable = true;
  };

  services.emacs = {
    enable = !isDarwin;
    defaultEditor = false;
    socketActivation = {
      enable = true;
    };
  };
}
