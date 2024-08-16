{
  description = "Matrix AI Public Overlay";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";

    polykey-cli.url = "github:MatrixAI/Polykey-CLI";
    polykey-cli.inputs.nixpkgs.follows = "nixpkgs";

    hercules-ci-gitignore.url = "github:hercules-ci/gitignore.nix";
    hercules-ci-gitignore.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ ... }:
    let
      overlay = import ./overlays/overlay.nix {
        inherit inputs;
      };

      modules = import ./modules/module-list.nix {
        inherit inputs;
      };
    in
    {
      overlays.default = overlay;
      nixosModules.default = modules;
    };
}
