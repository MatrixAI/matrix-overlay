{ system, lib }:

lib.makeExtensible (self: {
  polykey-cli = (builtins.getFlake
    "github:MatrixAI/Polykey-CLI/740c72d9c6d332f68a65af1e14b1aa5ae25cc274").packages.${system}.default;
})
