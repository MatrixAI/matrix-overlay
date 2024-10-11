{ system, lib }:

lib.makeExtensible (self: {
  polykey-cli = (builtins.getFlake
    "github:MatrixAI/Polykey-CLI/13d0a19b67e33a0f6f93545926dfce2f8b6c1b0e").packages.${system}.default;
})
