{ config, pkgs, ... }:

{
  services = {
    xserver = {
      excludePackages = with pkgs; [
      ];

    };
    displayManager = {
      sddm.enable = true;
      sddm.wayland.enable = true;
      # autoLogin = {
      #   enable = true;
      #   user = "user";
      # };
    };
    desktopManager = {
      plasma6.enable = true;
    };
  };

  environment.sessionVariables = {
    # If your cursor becomes invisible
    # WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
    # config.common.default = "kde";
  };

  users.users.user = {
    packages = with pkgs; [
    ];
  };

  environment.systemPackages = with pkgs; [
  ];
}

