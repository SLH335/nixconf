{
  inputs,
  self,
  ...
}: {
  # Factory: lets host modules build a per-host ghostty wrapper without going
  # through `self.packages.<sys>.ghostty` (which is the default-fontSize
  # build below). Hosts that just want defaults can use `self.packages.<sys>.ghostty`
  # directly; hosts that want overrides call `self.mkGhostty pkgs { fontSize = N; }`.
  flake.mkGhostty = pkgs: {fontSize ? 14}: let
    themePath = "${inputs.catppuccin.packages.${pkgs.stdenv.hostPlatform.system}.ghostty}/catppuccin-mocha.conf";
    configFile = pkgs.writeText "ghostty.conf" ''
      font-family = JetBrainsMono Nerd Font
      font-size = ${toString fontSize}
      window-padding-x = 10
      window-padding-y = 10
      window-decoration = false
      background-opacity = 0.9
      background-blur-radius = 20
      theme = light:${themePath},dark:${themePath}
      keybind = ctrl+h=goto_split:left
      keybind = ctrl+l=goto_split:right
    '';
  in
    inputs.wrapper-modules.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.ghostty;
      # Ghostty's CLI parser requires `--key=value` form; the default
      # space separator produces `--config-file <path>` which it parses
      # as two args ("config-file: value required" + "<path>: invalid field").
      flags."--config-file" = {
        sep = "=";
        data = "${configFile}";
      };
    };

  perSystem = {pkgs, ...}: {
    packages.ghostty = self.mkGhostty pkgs {};
  };
}
