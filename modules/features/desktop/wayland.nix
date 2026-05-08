{...}: {
  flake.modules.nixos.wayland = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      wdisplays
    ];

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];

      config = {
        common.default = ["gnome" "gtk"];
        niri = {
          default = ["gnome" "gtk"];
          # Route OpenURI and AppChooser to gtk under niri. gnome's
          # implementation can't position its chooser dialog without a
          # gnome-shell parent ("Failed to associate portal window with
          # parent window") and its launch path strips WAYLAND_DISPLAY,
          # so gnome-launched GUI apps silently fall through to X11
          # ("Failed to create window"). gtk's portal is desktop-agnostic
          # and inherits the env correctly.
          "org.freedesktop.impl.portal.OpenURI" = ["gtk"];
          "org.freedesktop.impl.portal.AppChooser" = ["gtk"];
        };
      };
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
