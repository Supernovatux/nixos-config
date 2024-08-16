pkgs:
let
  slurp = "${pkgs.slurp}/bin/slurp";
  satty = "${pkgs.satty}/bin/satty";
  grim = "${pkgs.grim}/bin/grim";
in
pkgs.writeShellScript "screenshot" ''
  SCREENSHOTS="$HOME/Pictures/Screenshots"
  NOW=$(date +%Y-%m-%d_%H-%M-%S)
  TARGET="$SCREENSHOTS/satty-$NOW.png"

  mkdir -p $SCREENSHOTS

  if [[ -n "$1" ]]; then
      ${grim} -g "$(${slurp} -c '#ff0000ff')" -t ppm - | ${satty} --filename - --output-filename $TARGET
  else
      sleep 1 && ${grim} -g "$(${slurp} -c '#ff0000ff')" -t ppm - | ${satty} --filename - --output-filename $TARGET
  fi
''
