{ pkgs, lib, ... }:

{
  # https://github.com/nix-community/home-manager/pull/2408
  environment.pathsToLink = [ "/share/fish" ];

  # Since we're using fish as our shell
  programs.fish.enable = true;

  users.users.cameron = {
    isNormalUser = true;
    home = "/home/cameron";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.fish;
    hashedPassword = "$6$SPf.1ec4OeNHM7Uy$5dJ40W1I0SJp3eFLgiMEsQB5ya2ExtnxKgSFYascMCyui9zMoH7AVxA71E9H7eensBMWlQ2aY2ilHUSG3HNB21";
  };

  services.redis.servers.cameron = {
    enable = true;
    port = 6379;
  };

  # Without this, nix complains of a clash between pipewire and pulseaudio.
  # Pipewire seems to be set through `gnome-remote-desktop` module, which
  # I cannot find any mention of within this repository.
  services.pipewire = {
    enable = lib.mkForce false;
  };

  # reset DPI to suit monitor
  services.xserver.dpi = lib.mkForce 120;

  nixpkgs.overlays = import ../../lib/overlays.nix;
}
