# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

 {
  imports =
    [
      #
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.tmp.cleanOnBoot = true;

  zramSwap.enable = true;

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # networking.firewall.checkReversePath = "loose";
  services.resolved.enable = true;

  networking.wireguard.enable = true;
  services.mullvad-vpn.enable = true;
  

  # Set your time zone.
  time.timeZone = "Asia/Seoul";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    packages = [pkgs.terminus_font];
    # font = "Lat2-Terminus16";
    # keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  nix.settings.experimental-features = ["nix-command" "flakes" ];

  fonts.fontDir.enable = true;

  nixpkgs.config = {
    permittedInsecurePackages = [
    #  "python-2.7.18.7"
    ];
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
      #  "amdgpu-pro"
      ];
  };

  environment.sessionVariables = {
    XDG_PICTURES_DIR="~/Persistent/home/Pictures";
    XDG_SCREENSHOTS_DIR="~/Persistent/home/Pictures/screenshots";
    EDITOR="nvim";
  };

  # environment.shells = with pkgs; [ bash zsh fish ];
  # users.defaultUserShell = pkgs.fish;
  # programs.fish.enable = true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  services.flatpak.enable = true;

  services = {
    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      # videoDrivers = [ "amdgpu-pro" ];

      xkb = {
      # Configure keymap in X11
        layout = "kr";
        model = "pc101";
        variant = "kr104";
        options = "korean";
      # desktopManager.runXdgAutostartIfNone = true;
      };
      excludePackages = with pkgs; [
      ];
    };
  };


  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-mono
      source-han-serif
      source-han-serif-japanese
      nerdfonts
      # (nerdfonts.override {fonts = ["Meslo"];})
    ];
    
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Meslo LG M Regular Nerd Font Complete Mono"];
      	serif = ["Noto Serif" "Source Han Serif"];
	      sansSerif = ["Noto Sans" "Source Han Sans"];
      };
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  hardware.bluetooth.enable = true;

  security.rtkit.enable = true; #rsh!
  services.pipewire = { # rsh!
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.gvfs.enable = true; # Mount, trash, and other functions
  programs.wireshark.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
    ];
  };

#  systemd.services.startup = {
#    enable = true;
#    description = "execute startup.sh";
#    unitConfig = {
#      # Type = "simple";
#      Type = "Application";
#    };
#    serviceConfig = {
#      ExecStart = "/bin/sh /nix/persist/home/user/Persistent/home/bin/startup.sh";
#    };
#    wantedBy = [ "multi-user.target" ];
#  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;

  users.users.user = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "wireshark"
    ]; # Enable ‘sudo’ for the user.

    packages = with pkgs; [
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nftables
    neovim
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default
    nix-index
    patchelf
    distrobox
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.fuse.userAllowOther = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "no";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .

  system.stateVersion = "24.05"; # Did you read the comment?

}

