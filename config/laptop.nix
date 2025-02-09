{ config, pkgs, ... }:

let
  userAliases = {
    flakenix="sudo nixos-rebuild boot --flake /home/user/.dotfiles#laptop --impure";
    flakenix-now="sudo nixos-rebuild switch --flake /home/user/.dotfiles#laptop --impure";
    flakehome="home-manager boot --flake ~/.dotfiles#laptop --impure";
    flakehome-now="home-manager switch --flake ~/.dotfiles#laptop --impure";
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
      macchanger

      # reaverwps-t6x
      # reaverwps
      bully
      hcxtools
      bettercap
      wirelesstools
      aircrack-ng

      pixiewps
      john
      wordlists
      wifite2
      crunch
      hashcat
      hashcat-utils
    ];

    file = {
    };
    sessionVariables = {
      DEVICE_IS_PC = "0";
      # EDITOR = "emacs";
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
