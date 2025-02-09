{ config, pkgs, pkgs-unstable, ... }:

let
  username = "user";
in 

{
  imports = [
  ];

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";

    packages =  
      (with pkgs; [
      ])

      ++

      (with pkgs-unstable; [
      ]);
    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      ".config/user-dirs.dirs".source = ./file/common/user-dirs_config.dirs;
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
