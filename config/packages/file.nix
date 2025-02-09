{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      # efibootmgr 
      file
      ntfs3g
      # fuse-common 
      # grub2 
      gparted
      # peazip
      p7zip
      qbittorrent
      # nfs-utils 
      rclone
      sshfs
      trash-cli
      ueberzugpp
      unar
      unzip
      zip
    ];
  };
}
