{ config, pkgs, ... }:

let
  userAliases = {
    ll = "ls -l";
    ".." = "cd ..";
  };
  username = "user";
in 

{
  imports = [
  ];

  home = {
    packages = with pkgs; [
      # themes
      libsForQt5.qtstyleplugins
      libsForQt5.qtstyleplugin-kvantum
      adwaita-qt
      adw-gtk3

      # fonts
      nerdfonts
      terminus-nerdfont 

      # swaycons  Window icons in Sway with Nerd Fonts
    ];
    file = {
    };
    sessionVariables = {
    };

  };

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      # package = pkgs.adw-gtk3;
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "adw-gtk3-dark";
      color-scheme = "prefer-dark";
    };
  };

  qt = {
      enable = true;
      # platformTheme.name = "gtk";
      platformTheme.name = "qtct";
      style = {
        name = "adwaita-dark";
        # package = pkgs.adwaita-qt;
      };
    };
}
