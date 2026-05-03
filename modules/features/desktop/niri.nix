{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.niri = {
    pkgs,
    config,
    ...
  }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    };

    home-manager.users.${config.slh.primaryUser} = self.modules.homeManager.niri;
  };

  flake.modules.homeManager.niri = {pkgs, ...}: {
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
    config,
    self',
    ...
  }: {
    packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs; # THIS PART IS VERY IMPORTAINT!!!
      v2-settings = true;
      settings = {
        prefer-no-csd = _: {};
        hotkey-overlay.skip-at-startup = _: {};
        spawn-at-startup = [
          (lib.getExe self'.packages.noctalia)
        ];
        # Outputs are managed by shikane (see modules/features/gui/shikane.nix),
        # which applies per-location profiles via wlr-output-management on the
        # connected displays.
        input = {
          touchpad = {
            natural-scroll = _: {};
            tap = _: {};
          };

          keyboard = {
            xkb = {
              layout = "eu";
              options = "caps:escape,lv3:ralt_switch";
            };
          };
          focus-follows-mouse = _: {};
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
          "Mod+Q".close-window = _: {};
          "Mod+F".set-column-width = "100%";
          "Mod+Ctrl+F".set-column-width = "50%";
          "Mod+Shift+F".fullscreen-window = _: {};
          "Mod+Space".spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call launcher toggle";
          "Mod+Semicolon".spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call lockScreen lock";
          "Mod+Period".spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call controlCenter toggle";
          "Mod+Comma".spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call settings toggle";
          "Mod+N".spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call notifications toggleHistory";
          "Mod+M".spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call media toggle";
          "Mod+Ctrl+Alt+Delete".spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call sessionMenu toggle";
          "Mod+Slash".spawn-sh = let
            noctalia = lib.getExe self'.packages.noctalia;
          in
            self.mkWhichKeyExe pkgs [
              {
                key = "w";
                desc = "WiFi";
                cmd = "${noctalia} ipc call network togglePanel";
              }
              {
                key = "v";
                desc = "Volume";
                cmd = "${noctalia} ipc call volume togglePanel";
              }
              {
                key = "f";
                desc = "Firefox";
                cmd = lib.getExe pkgs.firefox;
              }
              {
                key = "b";
                desc = "Brave";
                cmd = lib.getExe pkgs.brave;
              }
              {
                key = "B";
                desc = "Bluetooth";
                cmd = "${noctalia} ipc call bluetooth togglePanel";
              }
              {
                key = "s";
                desc = "Signal";
                cmd = lib.getExe pkgs.signal-desktop;
              }
              {
                key = "t";
                desc = "Telegram";
                cmd = lib.getExe pkgs.telegram-desktop;
              }
              {
                key = "m";
                desc = "btop";
                cmd = "${lib.getExe pkgs.ghostty} -e ${lib.getExe pkgs.btop}";
              }
              {
                key = "S";
                desc = "Steam";
                cmd = lib.getExe pkgs.steam;
              }
              {
                key = "T";
                desc = "Tor";
                cmd = lib.getExe pkgs.tor-browser;
              }
            ];

          "XF86AudioRaiseVolume" = _: {
            props.allow-when-locked = true;
            content.spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call volume increase";
          };
          "XF86AudioLowerVolume" = _: {
            props.allow-when-locked = true;
            content.spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call volume decrease";
          };
          "XF86AudioMute" = _: {
            props.allow-when-locked = true;
            content.spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call volume muteOutput";
          };
          "XF86AudioMicMute" = _: {
            # Mic-mute LED (/sys/class/leds/platform::micmute) is on the
            # audio-micmute trigger, so it auto-follows the PipeWire default
            # source mute state that wpctl (used by noctalia) flips.
            props.allow-when-locked = true;
            content.spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call volume muteInput";
          };
          "XF86MonBrightnessUp" = _: {
            props.allow-when-locked = true;
            content.spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call brightness increase";
          };
          "XF86MonBrightnessDown" = _: {
            props.allow-when-locked = true;
            content.spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call brightness decrease";
          };

          "Mod+Shift+Slash".show-hotkey-overlay = _: {};
          "Mod+Shift+M".quit = _: {};

          # --- Focus ---
          "Mod+H".focus-column-left = _: {};
          "Mod+L".focus-column-right = _: {};
          "Mod+J".focus-window-or-workspace-down = _: {};
          "Mod+K".focus-window-or-workspace-up = _: {};

          # --- Move windows ---
          "Mod+Shift+H".move-column-left = _: {};
          "Mod+Shift+L".move-column-right = _: {};
          "Mod+Shift+J".move-window-down-or-to-workspace-down = _: {};
          "Mod+Shift+K".move-window-up-or-to-workspace-up = _: {};

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

          "Mod+Ctrl+H".focus-monitor-left = _: {};
          "Mod+Ctrl+J".focus-monitor-down = _: {};
          "Mod+Ctrl+K".focus-monitor-up = _: {};
          "Mod+Ctrl+L".focus-monitor-right = _: {};

          "Mod+Shift+Ctrl+H".move-workspace-to-monitor-left = _: {};
          "Mod+Shift+Ctrl+J".move-workspace-to-monitor-down = _: {};
          "Mod+Shift+Ctrl+K".move-workspace-to-monitor-up = _: {};
          "Mod+Shift+Ctrl+L".move-workspace-to-monitor-right = _: {};

          "Mod+Alt+H".set-column-width = "-5%";
          "Mod+Alt+L".set-column-width = "+5%";
          "Mod+Alt+K".set-window-height = "-5%";
          "Mod+Alt+J".set-window-height = "+5%";

          "Mod+WheelScrollDown".focus-workspace-down = _: {};
          "Mod+WheelScrollUp".focus-workspace-up = _: {};
          "Mod+Shift+WheelScrollUp".focus-column-left = _: {};
          "Mod+Shift+WheelScrollDown".focus-column-right = _: {};
          "Mod+Ctrl+WheelScrollUp".focus-monitor-left = _: {};
          "Mod+Ctrl+WheelScrollDown".focus-monitor-right = _: {};
          "Mod+Ctrl+Shift+WheelScrollUp".focus-monitor-up = _: {};
          "Mod+Ctrl+Shift+WheelScrollDown".focus-monitor-down = _: {};

          "Mod+Tab".toggle-overview = _: {};
          "Mod+V".toggle-window-floating = _: {};

          "Mod+S".screenshot = _: {};
          "Mod+Shift+S".screenshot-screen = _: {};
          "Mod+Ctrl+S".screenshot-window = _: {};
        };
      };
    };
  };
}
