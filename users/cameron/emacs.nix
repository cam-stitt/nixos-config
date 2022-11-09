{ config, pkgs, lib, ... }:


with lib;
let
  emacsPkg = ( pkgs.emacs.overrideAttrs (oldAttrs: {
    configureFlags = oldAttrs.configureFlags ++
      [ "--without-toolkit-scroll-bars" "--with-x-toolkit=yes" ];
  }));
in
{
  programs.emacs = {
    enable = true;
    package = emacsPkg;
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
    package = emacsPkg;
    socketActivation = {
      enable = true;
    };
  };
}
