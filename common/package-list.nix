{pkgs, ...}:
with pkgs;
  [
    uutils-coreutils
    has
  ]
  ++ [
    aria2
    bat
    just
    lsd
    ripgrep
    safe-rm
    tre
    up
    zoxide
  ]
  ++ [
    neofetch
    bottom
    nodePackages.undollar
    nodePackages.fkill-cli
  ]
  ++ [manix]
  ++ [git gh]
