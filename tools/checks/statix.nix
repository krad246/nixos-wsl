{
  runCommand,
  statix,
  ...
}:
runCommand "check-statix" {nativeBuildInputs = [statix];} ''
  statix -i 2 -d $(find ${./..} -name '*.sh')
  touch $out
''
