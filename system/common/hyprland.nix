{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services = {
    xserver = {
      excludePackages = with pkgs; [
        xterm
      ];
    };
    displayManager = {
      sddm.enable = true;
      sddm.wayland.enable = true;
      autoLogin = {
        enable = true;
        user = "user";
      };
    };
  };

  environment.sessionVariables = {
    # If your cursor becomes invisible
    # WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    terminal = "kitty";
  };

  security.pam.services.swaylock = {};

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    config.common.default = "*";
  };

  # stylix = {
  #   enable = true;
  #   # image = ./wallpaper.png;
  #   polarity = "dark";
  # };

  services.tumbler.enable = true; # Thumbnail support for images

  programs.xfconf.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  users.users.user = {
    packages = with pkgs; [
    ];
  };

  environment.systemPackages = 
    let
      # bypass thunar open with.. requiring specific hardcoded terminals
      fakeXTerm = pkgs.runCommand "fake-xterm" { } ''
        mkdir -p "$out/bin"
        ln -s "${pkgs.kitty}/bin/kitty" "$out/bin/xterm"
      '';
    in with pkgs; [
      (lib.hiPrio fakeXTerm)
      # (xterm.override {
      #   xterm = fakeXTerm;
      #  })
      brightnessctl
      networkmanagerapplet
    ];

  powerManagement.resumeCommands = ''
    echo "Connecting to wifi after resuming.."
    sleep 5
    rmmod iwlmvm iwlfifi
    sleep 1
    modprobe iwlmvm iwlwifi
  '';

  security.polkit.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}

