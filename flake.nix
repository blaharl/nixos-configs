{
  description = "flake file";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    # nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # rust-overlay = {
    #   url = "github:oxalica/rust-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    # home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
    # plasma-manager = {
    #   url = "github:nix-community/plasma-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.home-manager.follows = "home-manager";
    # };
    # stylix.url = "github:danth/stylix";
  };

  # outputs = inputs@{ nixpkgs, impermanence, home-manager, stylix, nixpkgs-unstable, ... }: 
  outputs = inputs@{ nixpkgs, impermanence, home-manager, nixpkgs-unstable, ... }: 
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      username = "user";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in {
    nixosConfigurations = {
      debian = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [ 
          impermanence.nixosModules.impermanence
          ./system/import-desktop.nix
          home-manager.nixosModules.home-manager
          # stylix.nixosModules.stylix
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ 
              # plasma-manager.homeManagerModules.plasma-manager 
              # stylix.homeManagerModules.stylix
            ];
            home-manager.extraSpecialArgs = { inherit pkgs-unstable; };
            home-manager.users."${username}" = import ./config/desktop.nix;
          }
        ];
      };
      laptop = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          impermanence.nixosModules.impermanence
          ./system/import-laptop.nix
          home-manager.nixosModules.home-manager
          # stylix.nixosModules.stylix
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ 
              # plasma-manager.homeManagerModules.plasma-manager 
              # stylix.homeManagerModules.stylix
            ];
            home-manager.extraSpecialArgs = { inherit pkgs-unstable; };
            home-manager.users."${username}" = import ./config/laptop.nix;
          }
        ];
      };
    };
    # WIP
    homeConfigurations = {
      debian = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          # inputs.plasma-manager.homeManagerModules.plasma-manager
          ./config/desktop.nix
          {
            home = {
              inherit username;
              homeDirectory = "/home/${username}";
            };
          }
        ];
      };
      laptop = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          # inputs.plasma-manager.homeManagerModules.plasma-manager
          ./config/laptop.nix
          {
            home = {
              inherit username;
              homeDirectory = "/home/${username}";
            };
          }
        ];
      };
    };
  };
}
