{ config, pkgs, ... }:

{
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Define your hostname.
  networking.hostName = "debian";

  services.xserver.videoDrivers = [ "amdgpu" ];

  services.ollama = {
    enable = true;
    acceleration = "rocm";
    environmentVariables = {
      # used to be necessary, but doesn't seem to anymore
      HCC_AMDGPU_TARGET = "gfx1101";
    };
    rocmOverrideGfx = "11.0.1";
  };

  services.open-webui = {
    enable = true;
    port = 22025;
  };

  hardware = {
    graphics = {
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
	      # rocm-opencl-runtime
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    lact
    radeon-profile
  ];

  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  programs.corectrl = {
    enable = true;
    # gpuOverclock.enable = true;
  };


}
