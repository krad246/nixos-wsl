{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts = {
      url = github:hercules-ci/flake-parts;
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    flake-root.url = github:srid/flake-root;
    mission-control.url = github:Platonic-Systems/mission-control;

    systems.url = "github:nix-systems/default-linux";

    flake-utils.url = "github:numtide/flake-utils";
    flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";

    # utilities
    nixos-generators = {
      url = github:nix-community/nixos-generators;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix.url = github:numtide/treefmt-nix;
    disko = {
      url = github:nix-community/disko;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = inputs @ {
    flake-utils,
    nixpkgs,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };

        formatter = pkgs.alejandra;
        args = {
          inherit pkgs formatter;
        };

        tools = pkgs.callPackage ./tools args;
        mk = pkgs.callPackage ./mk-system.nix {inherit inputs;};
      in rec {
        inherit formatter;
        inherit (tools) checks devShells;

        nixosConfigurations = {
          nixos = mk.wslSystem {
            defaultUser = "Keerad";
            hostName = "nixos-wsl";
          };
        };

        legacyPackages = {
          inherit nixosConfigurations;
        };
      }
    );
}
