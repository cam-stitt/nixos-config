{ pkgs, lib, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  programs.emacs = {
    enable = !isDarwin;
  };

  services.emacs = {
    enable = !isDarwin;
    defaultEditor = false;
    socketActivation = {
      enable = true;
    };
  };
}
