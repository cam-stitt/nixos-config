{ pkgs, ... }:

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
    hashedPassword = "$5$/z/70DzKzOlgRhXi$Vk3bnNgp9qp5zzp9s6muEGiLEfoDYflljBhFoGg7wPC";
  };

  services.redis.servers.cameron = {
    enable = true;
    port = 6379;
  };

  nixpkgs.overlays = import ../../lib/overlays.nix;
}
