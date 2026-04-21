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
        niri.default = ["gnome" "gtk"];
      };
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
