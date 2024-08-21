{
  description = "Matrix AI Public Overlay";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        overlay = final: prev: { };
        pkgs = nixpkgs.legacyPackages.${system}.extend overlay;
        packages = import ./packages.nix { inherit system; };
      in {
        legacyPackages = pkgs;
        lib = pkgs.lib;
        packages = packages;
      });
}

