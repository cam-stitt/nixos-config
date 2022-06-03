{ pkgs, ... }:

{
  # https://github.com/nix-community/home-manager/pull/2408
  environment.pathsToLink = [ "/share/fish" ];

  users.users.cameron = {
    isNormalUser = true;
    home = "/home/cameron";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.fish;
    hashedPassword = "$5$/z/70DzKzOlgRhXi$Vk3bnNgp9qp5zzp9s6muEGiLEfoDYflljBhFoGg7wPC";
  };

  services.redis.enable = true;

  nixpkgs.overlays = import ../../lib/overlays.nix;
}
