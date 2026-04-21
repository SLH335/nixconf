{...}: {
  flake.nixosModules.greetd = {
    lib,
    pkgs,
    ...
  }: {
    services.greetd = {
      enable = true;
      settings.default_session = {
        # The --theme spec uses ANSI color names, resolved through the VT
        # palette that catppuccin.tty maps to Catppuccin Mocha colors. Single
        # quotes are required so greetd's shell-lexer treats the semicolons
        # as part of one argument.
        #   magenta = pink, cyan = teal, brightblack = surface2, white = subtext1
        command = "${lib.getExe pkgs.tuigreet} --time --remember --remember-session --asterisks --sessions /run/current-system/sw/share/wayland-sessions --theme 'container=brightblack;border=magenta;title=magenta;text=white;time=brightwhite;greet=white;prompt=cyan;input=brightcyan;action=brightblack;button=magenta'";
        user = "greeter";
      };
    };
  };
}
