{ inputs }:

final: prev:
let
  inherit (import inputs.hercules-ci-gitignore { inherit (final) lib; }) gitignoreFilterWith;
in {
  nixos = configuration:
    let
      modules = import ../modules/module-list.nix { inherit inputs; };
    in
      prev.nixos (
        if builtins.isList configuration
        then configuration ++ modules
        else [configuration] ++ modules
      );

  polykey-cli = inputs.polykey-cli.packages.x86_64-linux.default;

  # A utility function to ignore files from the nix store based on the rules
  # specified in the .gitignore file along with any additional filters that we
  # have specified. Functionally works similar to nix-gitignore's syntax of:
  # filteredFiles = gitignore [ "ignoreThisFile", "ignoreThisToo" ] ./.;
  # In this case, filteredFiles will not contain "ignoreThisFile", 
  # "ignoreThisToo", along with all the rules specified in the .gitignore file.
  gitignore = excludes: src:
    let
      gitignoreContents = builtins.readFile (src + "/.gitignore");
      extraRules = builtins.concatStringsSep "\n" excludes;
      srcIgnored = gitignoreFilterWith {
        basePath = src;
        extraRules = "${gitignoreContents}\n${extraRules}";
      };
    in
      builtins.filterSource (path: type: srcIgnored path type) src;
}
