{ config, pkgs, ... }:

let
  electronArgs = [
    "--gtk-version=4"
    "--wayland-text-input-v3=enabled"
    "--enable-wayland-ime"
  ];
in 

{
  home = {
    packages = with pkgs; [
      signal-desktop
      (ungoogled-chromium.override {
        commandLineArgs = electronArgs;
       })
    ];
  };

  xdg.desktopEntries.signal-desktop = {
    name = "Signal";
    genericName = "Messenger";
    exec = "signal-desktop --enable-wayland-ime --no-sandbox %U";
    icon = "signal-desktop";
    terminal = false;
    type = "Application";
    categories = [ "Network" "InstantMessaging" "Chat" ];
    # startupWMClass="signal";
    comment="Private messaging from your desktop";
    mimeType = [ "x-scheme-handler" "x-scheme-handler/sgnl" "x-scheme-handler/signalcaptcha" ];
  };

}
