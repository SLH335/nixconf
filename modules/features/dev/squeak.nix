{...}: {
  flake.modules.nixos.squeak = {pkgs, ...}: let
    # Default bundle location. The image file is mutable (Squeak writes a
    # sibling .changes file and may rewrite the image on save), so we keep
    # the bundle in the user's home rather than copying it into the store.
    defaultBundle = "$HOME/.local/share/SWE2026-v1";

    launcher = pkgs.writeShellScript "squeak-launcher" ''
      set -e
      BUNDLE="''${SQUEAK_BUNDLE:-${defaultBundle}}"
      if [ $# -gt 0 ]; then
        exec "$@"
      fi
      if [ ! -x "$BUNDLE/squeak.sh" ]; then
        echo "squeak: bundle not found at $BUNDLE" >&2
        echo "  Set SQUEAK_BUNDLE=/path/to/bundle or pass a command explicitly." >&2
        exit 1
      fi
      cd "$BUNDLE"
      exec ./squeak.sh
    '';

    fhs = pkgs.buildFHSEnv {
      name = "squeak";
      runScript = "${launcher}";
      targetPkgs = p:
        with p; [
          glibc
          zlib
          libuuid
          libx11
          libxext
          libxrender
          libice
          libsm
          libGL
          fontconfig
          freetype
          pango
          cairo
          harfbuzz
          glib
          alsa-lib
          libpulseaudio
          sndio
          dbus

          libgit2
          cacert
          openssh
          openssl
          git
        ];
    };

    desktopItem = pkgs.makeDesktopItem {
      name = "squeak";
      desktopName = "Squeak";
      genericName = "Smalltalk Environment";
      comment = "Squeak/Smalltalk programming system (SWE2026 bundle)";
      exec = "squeak";
      icon = "squeak";
      terminal = false;
      categories = ["Development" "IDE"];
      startupWMClass = "Squeak";
    };

    squeak = pkgs.symlinkJoin {
      name = "squeak";
      paths = [fhs desktopItem];
    };
  in {
    environment.systemPackages = [squeak];

    # Squeak's heartbeat thread wants real-time scheduling priority.
    # Without this, the VM prints a non-fatal warning on every launch.
    # Mirrors what upstream's squeak.sh would write to /etc/security/limits.d.
    security.pam.loginLimits = [
      {
        domain = "*";
        type = "soft";
        item = "rtprio";
        value = "2";
      }
      {
        domain = "*";
        type = "hard";
        item = "rtprio";
        value = "2";
      }
    ];
  };
}
