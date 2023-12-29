{inputs, ...}: let
  inherit (inputs) nixos-wsl;
in {
  imports = [./overrides.nix] ++ [nixos-wsl.nixosModules.wsl];
}
