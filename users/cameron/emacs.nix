{ config, pkgs, lib, ... }:

with lib;
let
  isDarwin = pkgs.stdenv.isDarwin;

  emacsPkg = if isDarwin then pkgs.emacs else ( pkgs.emacs.overrideAttrs (oldAttrs: {
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
    enable = !isDarwin;
    defaultEditor = false;
    package = emacsPkg;
    socketActivation = {
      enable = true;
    };
  };
}
