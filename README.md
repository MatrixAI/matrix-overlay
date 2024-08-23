# nixpkgs-matrix

Matrix AI's public Nix Packages collection.

## Contents

- [Installation](#installation)
  - [How to use](#how-to-use)
  - [Include in flake.nix](#include-in-flakenix)
- [Development](#development)
  - [Project structure](#project-structure)
- [License](#license)

## Installation

### How to use

This repository is configured to support Flakes, an extra-experimental feature in the Nix package manager. To enable it, either append the following argument to every command involving flakes:

```
nix <command> --extra-experimental-features flakes
```

Or you can permanently enable it by setting this in your configuration.nix:

```
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

### Include in flake.nix

To use this custom package set, you will need to update your `flake.nix` to target `MatrixAI/nixpkgs-matrix` instead of `NixOS/nixpkgs`.

Example configuration:

```nix
{
  inputs = {
    nixpkgs-matrix.url = "github:MatrixAI/nixpkgs-matrix";
  };

  outputs = inputs@{ nixpkgs-matrix, ... }:
  let
    username = "myuser";
    hostname = "myhostname";
    system = "mysystem";

    pkgs = nixpkgs-matrix.legacyPackages.${system};
  in
  {
    nixosConfigurations.${hostname} = nixpkgs-matrix.lib.nixosSystem {
      specialArgs = { inherit inputs username hostname system; };
      modules = [ ./configuration.nix ];
    };
  };
}
```

Diff of typical flake configuration:

```diff
diff --git a/old.nix b/new.nix
index c96b76d..a2d90f3 100644
--- a/old.nix
+++ b/new.nix
@@ -1,20 +1,18 @@
 {
   inputs = {
-    nixpkgs.url = "github:NixOS/nixpkgs";
+    nixpkgs-matrix.url = "github:MatrixAI/nixpkgs-matrix";
   };
 
-  outputs = inputs@{ nixpkgs, ... }:
+  outputs = inputs@{ nixpkgs-matrix, ... }:
   let
     username = "myuser";
     hostname = "myhostname";
     system = "mysystem";
 
-    pkgs = import nixpkgs {
-      config.allowUnfree = true;
-    };
+    pkgs = nixpkgs-matrix.legacyPackages.${system};
   in
   {
-    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
+    nixosConfigurations.${hostname} = nixpkgs-matrix.lib.nixosSystem {
       specialArgs = { inherit inputs username hostname system; };
       modules = [ ./configuration.nix ];
     };
```

## Development

This repository contains a few important files to look at when contributing to the project.

- `flake.nix`- Contains the base definition for the flake package. Re-exports our modified package set as an output.
- `packages.nix` - Custom packages are placed here. This needs to be done using `builtins.getFlake` and must provide a revision hash.

### Project structure

```
/nixpkgs-matrix
├── flake.nix - The primary flake file.
└── packages.nix - This is where in-tree packages exist.
```

## License

Thes source code for this project is licensed under the Apache 2.0 License. You may find the conditions of the license [here](LICENSE).
