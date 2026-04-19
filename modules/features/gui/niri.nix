{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.niri = {
    pkgs,
    lib,
    ...
  }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };

    home-manager.users.slh = self.homeModules.niri;
  };

  flake.homeModules.niri = {pkgs, ...}: {
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs; # THIS PART IS VERY IMPORTAINT!!!
      settings = {
        prefer-no-csd = null;
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];
        input = {
          touchpad = {
            natural-scroll = null;
            tap = null;
          };

          keyboard = {
            xkb = {
              layout = "eu";
              options = "caps:escape,lv3:ralt_switch";
            };
          };
        };
        cursor = {
          xcursor-theme = "Bibata-Modern-Classic";
          xcursor-size = 24;
        };
        environment = {
          XCURSOR_THEME = "Bibata-Modern-Classic";
          XCURSOR_SIZE = "24";
        };
        window-rule = {
          geometry-corner-radius = 12;
          clip-to-geometry = true;
          draw-border-with-background = false;
        };
        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
        layout = {
          gaps = 8;

          focus-ring = {
            active-color = "#b4befe";
          };
        };
        binds = {
          "Mod+Return".spawn-sh = "${lib.getExe pkgs.ghostty} --gtk-single-instance=true";
          "Mod+Q".close-window = null;
          "Mod+F".set-column-width = "100%";
          "Mod+Ctrl+F".set-column-width = "50%";
          "Mod+Shift+F".fullscreen-window = null;
          "Mod+Space".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
          "Mod+Semicolon".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call lockScreen lock";
          # "Mod+S".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc controlCenter toggle";
          # "Mod+Comma".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc settings toggle";
          # "Mod+Ctrl+Delete".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc sessionMenu toggle";

          # "XF86AudioRaiseVolume".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc volume increase";
          # "XF86AudioLowerVolume".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc volume decrease";
          # "XF86AudioMute".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc volume muteOutput";
          # "XF86MonBrightnessUp".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc brightness increase";
          # "XF86MonBrightnessDown".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc brightness decrease";

          "Mod+Slash".show-hotkey-overlay = null;
          "Mod+Shift+M".quit = null;

          # --- Focus ---
          "Mod+H".focus-column-left = null;
          "Mod+L".focus-column-right = null;
          "Mod+J".focus-window-or-workspace-down = null;
          "Mod+K".focus-window-or-workspace-up = null;

          # --- Move windows ---
          "Mod+Shift+H".move-column-left = null;
          "Mod+Shift+L".move-column-right = null;
          "Mod+Shift+J".move-window-down-or-to-workspace-down = null;
          "Mod+Shift+K".move-window-up-or-to-workspace-up = null;

          # --- Switch Workspace ---
          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;
          "Mod+0".focus-workspace = 10;

          # --- Move Window to Workspace ---
          "Mod+Shift+1".move-window-to-workspace = 1;
          "Mod+Shift+2".move-window-to-workspace = 2;
          "Mod+Shift+3".move-window-to-workspace = 3;
          "Mod+Shift+4".move-window-to-workspace = 4;
          "Mod+Shift+5".move-window-to-workspace = 5;
          "Mod+Shift+6".move-window-to-workspace = 6;
          "Mod+Shift+7".move-window-to-workspace = 7;
          "Mod+Shift+8".move-window-to-workspace = 8;
          "Mod+Shift+9".move-window-to-workspace = 9;
          "Mod+Shift+0".move-window-to-workspace = 10;

          "Mod+Ctrl+H".focus-monitor-left = null;
          "Mod+Ctrl+J".focus-monitor-down = null;
          "Mod+Ctrl+K".focus-monitor-up = null;
          "Mod+Ctrl+L".focus-monitor-right = null;

          "Mod+Shift+Ctrl+H".move-workspace-to-monitor-left = null;
          "Mod+Shift+Ctrl+J".move-workspace-to-monitor-down = null;
          "Mod+Shift+Ctrl+K".move-workspace-to-monitor-up = null;
          "Mod+Shift+Ctrl+L".move-workspace-to-monitor-right = null;

          "Mod+Alt+H".set-column-width = "-5%";
          "Mod+Alt+L".set-column-width = "+5%";
          "Mod+Alt+K".set-window-height = "-5%";
          "Mod+Alt+J".set-window-height = "+5%";

          "Mod+WheelScrollDown".focus-workspace-down = null;
          "Mod+WheelScrollUp".focus-workspace-up = null;

          "Mod+Tab".toggle-overview = null;
          "Mod+V".toggle-window-floating = null;

          "Mod+S".screenshot = null;
          "Mod+Shift+S".screenshot-screen = null;
          "Mod+Ctrl+S".screenshot-window = null;
        };
      };
    };
  };
}
