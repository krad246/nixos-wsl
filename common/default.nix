{
  config,
  lib,
  pkgs,
  ...
}: {
  imports =
    [./nix-daemon.nix]
    ++ [
      ./system-packages.nix
      ./managed-users.nix
    ]
    ++ [./system-settings.nix]
    ++ [./version.nix];
}
