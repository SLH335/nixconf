{...}: {
  flake.nixosModules.greetd = {
    lib,
    pkgs,
    ...
  }: {
    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${lib.getExe pkgs.tuigreet} --time --remember --remember-session --asterisks --sessions /run/current-system/sw/share/wayland-sessions";
        user = "greeter";
      };
    };
  };
}
