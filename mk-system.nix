{
  system,
  inputs,
  ...
} @ rest: let
  inherit (inputs) nixpkgs;

  pkgs = import nixpkgs {inherit system;};
  inherit (pkgs) lib;

  mkArgs = args @ {
    defaultUser ? "nixos",
    hostName ? "nixos-wsl",
    ...
  }:
    {}
    // {
      inherit system;
      modules = [./configuration.nix] ++ [./wsl-config];
      specialArgs = args // {inherit inputs;};
    };

  mkSystem = args: nixpkgs.lib.nixosSystem (mkArgs args);
in {
  wslSystem = args: mkSystem args;
}
