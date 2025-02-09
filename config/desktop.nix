{ config, pkgs, ... }:

let
  userAliases = {
    flakenix="sudo nixos-rebuild boot --flake /home/user/.dotfiles#debian --impure";
    flakenix-now="sudo nixos-rebuild switch --flake /home/user/.dotfiles#debian --impure";
    flakehome="home-manager boot --flake ~/.dotfiles#debian --impure";
    flakehome-now="home-manager switch --flake ~/.dotfiles#debian --impure";
    flakeupdate="cd ~/.dotfiles; nix flake update";
  };
  username = "user";
in 

{
  imports = [
    ./home.nix
    ./packages
    ./hyprland.nix
  ];

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    stateVersion = "24.05";

    packages = with pkgs; [
    ];

    file = {
    };

    sessionVariables = {
      DEVICE_IS_PC = "1";
    };
  };

  programs.bash = {
    shellAliases = userAliases;
  };

  programs.fish = {
    shellAliases = userAliases;
  };

  programs.zsh = {
    shellAliases = userAliases;
  };
}
