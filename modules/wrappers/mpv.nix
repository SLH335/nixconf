{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.mpv = inputs.wrapper-modules.wrappers.mpv.wrap {
      inherit pkgs;
      "mpv.conf".content = ''
        profile=gpu-hq
        vo=gpu-next
        gpu-context=wayland
        hwdec=auto-safe
        keep-open=yes
        save-position-on-quit=yes

        [dont-save-at-end]
        profile-cond=eof_reached
        save-position-on-quit=no
      '';
      "mpv.input".content = ''
        h seek -5
        l seek 5
        j add volume -2
        k add volume 2
        H seek -60
        L seek 60
        q quit
        ESC quit
        f cycle fullscreen
      '';
    };
  };
}
