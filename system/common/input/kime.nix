{ config, pkgs, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "kime";
    # kime.config = {
    #   indicator.icon_color = "White";
    # };
  };
}

