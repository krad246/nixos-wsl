{impermance, ...}: {
  environment.persistence."/nix/persist/system" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      "/etc/machine-id"
      {
        file = "/etc/nix/id_rsa";
        parentDirectory = {mode = "u=rwx,g=,o=";};
      }
    ];
  };
}
