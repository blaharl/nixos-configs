{ config, pkgs, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        kdePackages.fcitx5-qt
        fcitx5-hangul
        fcitx5-gtk
      # fcitx5-mozc
      # fcitx5-skk-qt
      # libsForQt5.fcitx5-qt
      ];
      waylandFrontend = true;
    };
  };

  environment.sessionVariables = {
    GTK_IM_MODULE="fcitx";
    QT_IM_MODULE="fcitx";
  };
}

