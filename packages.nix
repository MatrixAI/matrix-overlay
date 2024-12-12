{ system, lib }:

lib.makeExtensible (self: {
  polykey-cli = (builtins.getFlake
    "github:MatrixAI/Polykey-CLI/69ac773b4b5aed49895b40e4ec6ec533b0ffcbca").packages.${system}.default;
})
