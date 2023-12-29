{
  pkgs,
  lib,
  ...
}: {
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Here's a baseline example using the existing 'nixos' user.
  users.users.nixos = lib.mkDefault {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
  };

  virtualisation.docker.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
