{ system, lib }:

lib.makeExtensible (self: {
  polykey-cli = (builtins.getFlake
    "github:MatrixAI/Polykey-CLI/73e25d8aa49873f7b6ea1be38f37408649c6c24e").packages.${system}.default;
})
