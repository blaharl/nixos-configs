{ config, pkgs, ... }:

{
  # Enable dconf (System Management Tool)
  programs.dconf.enable = true;

  # Add user to libvirtd group
  users.users.user.extraGroups = [ 
    "libvirtd"
    "docker"
    "podman"
  ];

  # Install necessary packages
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    virtiofsd
    spice spice-gtk
    spice-protocol
    win-virtio
    win-spice
    # gnome.adwaita-icon-theme
    adwaita-icon-theme
  ];

  # Manage the virtualisation services

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };

    # Enable common container config files in /etc/containers
    containers.enable = true;
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };

    # docker = {
    #   enable = true;
    #   storageDriver = "btrfs";
    #   rootless = {
    #     enable = true;
    #     setSocketVariable = true;
    #   };
    # };

    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
}
