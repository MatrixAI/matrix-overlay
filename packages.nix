{ system, lib }:

lib.makeExtensible (self: {
  polykey-cli = (builtins.getFlake
    "github:MatrixAI/Polykey-CLI/40fb687c9209408965043c2b322f3a2643e275bc").packages.${system}.default;
})
