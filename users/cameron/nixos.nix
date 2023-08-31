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
    hashedPassword = "$6$SPf.1ec4OeNHM7Uy$5dJ40W1I0SJp3eFLgiMEsQB5ya2ExtnxKgSFYascMCyui9zMoH7AVxA71E9H7eensBMWlQ2aY2ilHUSG3HNB21";
  };

  services.redis.servers.cameron = {
    enable = true;
    port = 6379;
  };

  nixpkgs.overlays = import ../../lib/overlays.nix;
}
