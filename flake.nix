{
  description = "Matrix AI Public Overlay";

  inputs = {
    nixpkgs.url =
      "github:NixOS/nixpkgs/8ab83a21276434aaf44969b8dd0bc0e65b97a240";
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

