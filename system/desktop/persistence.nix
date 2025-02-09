{
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/etc/mullvad-vpn"
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"
      "/tmp" # gets cleaned on reboot if you set boot.tmp.cleanOnBoot to true
      "/var/cache/mullvad-vpn"
      # "/var/db/dhcpcd"
      # "/var/db/sudo/lectured"
      "/var/lib/alsa"
      "/var/lib/bluetooth"
      "/var/lib/flatpak"
      "/var/lib/libvirt"
      "/var/lib/nixos"
      "/var/lib/private"
      # "/var/lib/systemd" #systemd stuff
      "/var/tmp"
    ];
    files = [
      # "/etc/machine-id" # needs to be located on tmpfs
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
    users.user = {
      directories = [
        ".dotfiles"
        ".cache/goldendict"
        ".cache/mesa_shader_cache"
        ".cache/tealdeer"
        "Downloads"
        "Persistent"
        ".local/share/flatpak"
        ".var/app"
        ".config/environment.d"
        ".local/state/nix"
        ".local/state/home-manager"
        ".config/nvim"
        ".local/share/nvim"
        ".local/share/Steam"
      ];
      files = [
        #".bash_history"
      ];
    };
  };
}
