{ config, pkgs-unstable, ... }:

{
  home = {
    packages = with pkgs-unstable; [
      freetube
      ghostty
      wikiman
      yazi
      yt-dlp
    ];
  };
}
