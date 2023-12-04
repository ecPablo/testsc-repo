{
  description = "A simple Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.hello;
    defaultPackage.x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.hello;
    defaultPackage.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.hello;
  };
}
