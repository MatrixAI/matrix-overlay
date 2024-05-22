{
  description = "Matrix AI Public Overlay";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";

    # Custom packages
    polykey-cli.url = "github:MatrixAI/Polykey-CLI";
    polykey-cli.inputs.nixpkgs.follows = "nixpkgs"; # Inheriting the nixpkgs input above; pinned
  };

  outputs = inputs@{ nixpkgs, flake-utils, ... }:
    let
      overlay = import ./overlays/overlay.nix {
        inherit inputs; # Import the inputs into the overlay.nix
      };

      modules = import ./modules/module-list.nix {
        inherit inputs; # Same here
      };
    in
    {
      overlays.default = overlay; # Overlay exposed to external flakes

      nixosModules.default = modules; # Modules exposed to external flakes
    } //

    # The rest of this code is for testing purposes
    flake-utils.lib.eachSystem flake-utils.lib.allSystems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in
      {
        devShells.default = with pkgs; mkShell {
          inputsFrom = [
            polykey-cli
          ];
        };
      }
    );
}
