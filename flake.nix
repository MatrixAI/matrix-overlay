{
  description = "Matrix AI Public Overlay";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system: 
      let
        overlay = final: prev: (import ./packages.nix) { inherit system; };
        pkgs = nixpkgs.legacyPackages.${system}.extend overlay;
      in
      {
        legacyPackages = pkgs;
      });
}

