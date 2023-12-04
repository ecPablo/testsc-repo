{
  description = "Manifest - index composable data and software models in a git repository";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
  # it enables us to generate all outputs for each default system
  (
    flake-utils.lib.eachDefaultSystem
    (system: let
      # choose nixpkgs system?
      pkgs = import nixpkgs {
        inherit system;
      };

      # wrap together dependencies for plugins
      commonArgs = {
        inherit pkgs;
      };

      # import custom plugins with required args
      models = pkgs.callPackage ./.manifest commonArgs;

      # it flats the set tree of the plugins for packages and shell.
      # (e.g. [ packages.pkg1, packages.pkg2 ] -> [ pkg1, pkg2 ] )
      modelsPackage = flake-utils.lib.flattenTree models.packages;
    in {
      # it outputs packages all packages defined in plugins
      packages = modelsPackage;
    })
  );
}