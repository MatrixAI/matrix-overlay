{ system, lib }:

lib.makeExtensible (self: {
  polykey-cli = (builtins.getFlake
    "github:MatrixAI/Polykey-CLI/8981bd48ce2db238b1adcfee69aa5552ecff78fb").packages.${system}.default;
})
