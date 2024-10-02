{ system, lib }:

lib.makeExtensible (self: {
  polykey-cli = (builtins.getFlake
    "github:MatrixAI/Polykey-CLI/219b965e47c70422f840e537b74d8937e9a046b1").packages.${system}.default;
})
