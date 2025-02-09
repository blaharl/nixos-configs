{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      # cargo # not compatible with rustup
      gcc
      gdb
      gdbgui # browser based gdb frontend
      gef
      git
      gittyup
      gitui
      gnumake
      hugo
      luarocks
      # ninja 
      nodejs 
      postgresql
      python3Full
      # python.pkgs.pip
      python311Packages.pip
      R
      rstudio
      rustup # collision with cargo
      sqlite
      # stdenv 
      texliveFull
      typst
    ];
    file = {
      # ".clangd".source = ./file/common/clangd;
      # g++ -E -v -xc++ /dev/null
    };
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "user";
    userEmail = "user@localhost";
    extraConfig = {
      core = {
        sshCommand = "/usr/bin/env ssh -i /home/user/.ssh/id_github";
      };
    };
  };
}
