{
  config,
  lib,
  pkgs,
  ...
}: {
  # Upgrade to flake package and enable the daemon service.
  nix = {
    package = pkgs.nixFlakes;
    checkConfig = true;
    settings = {
      auto-optimise-store = true;
      sandbox = true;
      experimental-features = ["nix-command flakes"];
    };

    gc.automatic = true;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';
  };
}
