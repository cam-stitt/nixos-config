{ config, pkgs, lib, ... }:


with lib;
let
  emacsPkg = ( pkgs.emacs.overrideAttrs (oldAttrs: {
    configureFlags = oldAttrs.configureFlags ++
      [ "--without-toolkit-scroll-bars" "--with-x-toolkit=yes" ];
    buildInputs = oldAttrs.buildInputs ++
      [ pkgs.gtk3.dev ];
  }));
in
{
  programs.emacs = {
    enable = true;
    package = emacsPkg;
  };

  services.emacs = {
    enable = true;
    defaultEditor = false;
    package = emacsPkg;
    socketActivation = {
      enable =  false;
    };
  };
}
