{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    configFile = pkgs.writeText "zellij-config.kdl" ''
      default_layout "compact"
      pane_frames false
      copy_command "wl-copy"
      show_startup_tips false
      // catppuccin-mocha is built into zellij since v0.40
      theme "catppuccin-mocha"
    '';
  in {
    packages.zellij = inputs.wrapper-modules.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.zellij;
      env.ZELLIJ_CONFIG_FILE = "${configFile}";
    };
  };
}
