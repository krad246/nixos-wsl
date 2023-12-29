{
  pkgs,
  formatter ? pkgs.nixpkgs-fmt,
  ...
} @ args: let
  shellenv = pkgs.callPackage ./shellenv.nix args;
in {
  devShells = {default = shellenv;};
  checks = {};
}
