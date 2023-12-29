{lib, ...}: let
  extraGroups = ["wheel"];
in {
  # Stock NixOS users
  users.users.root = {
    inherit extraGroups;
  };

  users.users.nixos = lib.mkDefault {
    isNormalUser = true;
    uid = lib.mkForce 1000;
    inherit extraGroups;
  };

  users.users.Keerad = {
    isNormalUser = true;
    uid = lib.mkForce 1001;
    inherit extraGroups;
  };
}
