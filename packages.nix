{ system, lib }:

lib.makeExtensible (self: {
  polykey-cli = (builtins.getFlake
    "github:MatrixAI/Polykey-CLI/6d7224dddbb7356e74acf4f117892766a73f9cc9").packages.${system}.default;
})
