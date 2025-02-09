{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      audacity
      audio-recorder
      bitcoin
      electrum
      fontconfig
      freetype  # font rendering engine
      # gedit
      gnome-sound-recorder
      inkscape
      # libverto 
      libresprite
      losslesscut-bin
      monero-cli
      monero-gui
      # sxhkd # simple X hotkey daemon
      # synergy # share mouse and keyboard between multiple computers
      ttygif
      t-rec
    ];
  };
}
