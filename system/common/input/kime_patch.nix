{ inputs, ... }:

{
  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default

    (final: prev: {
      kime = prev.callPackage ./overlays/kime.nix {
        inherit (final) rust-bin;
      };
    })
  ];
}
