{
  description = "Matrix AI Public Overlay";

  inputs = {
    nixpkgs.url =
      "github:NixOS/nixpkgs/3f33387a5c85d94b305062a4f97d5b2899094efa";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      nixpkgs_ = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      packages = final: prev: (nixpkgs_.callPackage ./packages.nix { });
      pkgs = nixpkgs_.extend packages;
    in {
      legacyPackages.${system} = pkgs;
      nixpkgs = nixpkgs_;
      lib = nixpkgs_.lib;
    };
}

