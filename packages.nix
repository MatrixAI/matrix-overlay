{ system, lib }:

lib.makeExtensible (self: {
  polykey-cli = (builtins.getFlake
    "github:MatrixAI/Polykey-CLI/3942fb323103035cbc46b48906eebf69672bae43").packages.${system}.default;
})
