{ system, lib }:

lib.makeExtensible (self: {
  polykey-cli = (builtins.getFlake
    "github:MatrixAI/Polykey-CLI/3377c18e4384168f34d1c4437e0468c00bd9b3b8").packages.${system}.default;
})
