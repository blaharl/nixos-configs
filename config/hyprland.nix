{ config, pkgs, ... }:

let
  userAliases = {
    hyprunlock="pkill -USR1 hyprlock";
    openhome="sudo nft -f ~/.dotfiles/scripts/excludeTraffic.rules; sleep 1; mullvad connect; sleep 1; mullvad reconnect; pkill hypridle";
  };
in 

{
  imports = [
    ./theme.nix
  ];

  home = {
    packages = with pkgs; [
      eww
      hypridle
      hyprlock
      swaylock
      wlogout
      xfce.thunar
      nwg-look

      wev
      wl-clipboard
      wofi # bemenu, fuzzel, tofi 

      polkit_gnome

      #wallpapers
      hyprpaper
      swaybg
      wpaperd
      mpvpaper
      swww

      dunst
      libnotify

      (waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        })
      )

    ];
    file = {
      ".config/hypr/hyprland.conf".source = ./file/hyprland/hyprland_hypr_config.conf;
      ".config/fcitx5/config".source = ./file/hyprland/fcitx5_config_config;
      ".config/fcitx5/profile".source = ./file/hyprland/fcitx5_profile_config;
      ".config/fcitx5/conf/hangul".source = ./file/hyprland/fcitx5_conf_hangul_config.conf;
      ".config/swaylock/config".source = ./file/hyprland/swaylock_config_config;
      ".config/gtk-3.0/bookmarks".source = ./file/hyprland/gtk-3.0_bookmarks_config;
    };
    sessionVariables = {
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
