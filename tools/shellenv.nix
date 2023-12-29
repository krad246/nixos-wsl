{
  pkgs,
  formatter,
  packages ? [],
  ...
}:
pkgs.mkShell {inherit packages;} // formatter
