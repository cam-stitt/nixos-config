{ callPackage ? pkgs.callPackage
, pkgs ? import <nixpkgs> {} }:

callPackage (import ./hashicorp/generic.nix) {
  name = "nomad";
  version = "1.0.15";
  sha256 = "sha256-gTKC0sZhrNkE94LuNZPj7qMpXRBhkRmdDBfX4m+QMF8=";
}
