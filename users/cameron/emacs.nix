{ config, pkgs, lib, ... }:


with lib;
{
  programs.emacs = {
    enable = true;
    package = ( pkgs.emacs.overrideAttrs (oldAttrs: {
    configureFlags = oldAttrs.configureFlags ++
      [ "--without-toolkit-scroll-bars" "--with-x-toolkit=yes" ];
    }));
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
    socketActivation = {
      enable = true;
    };
  };
}
