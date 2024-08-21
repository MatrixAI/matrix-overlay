{
  description = "Matrix AI Public Overlay";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        packages = pkgs.callPackage ./packages.nix { };
        overlay = final: prev: packages;
      in {
        packages = packages;
        legacyPackages = pkgs.extend overlay;
        lib = nixpkgs.lib;
      });
}

