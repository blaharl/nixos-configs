{ config, pkgs, ... }:

let
  unstableTarball =
    fetchTarball
      # https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
      # https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz;
      https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz;
in

{
  nixpkgs.config = {
    packageOverrides = pkgs: with pkgs; {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };
  environment.systemPackages = with pkgs; [
    # unstable.neovim
    unstable.freetube
  ];
}
