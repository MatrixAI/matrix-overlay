{ system, lib }:

lib.makeExtensible (self: {
  polykey-cli = (builtins.getFlake
    "github:MatrixAI/Polykey-CLI/e4522475e79957aaef16dca39e55024d1a508ce6").packages.${system}.default;
})
