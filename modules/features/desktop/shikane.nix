{self, ...}: {
  flake.modules.nixos.shikane = {
    home-manager.users.slh = self.modules.homeManager.shikane;
  };

  flake.modules.homeManager.shikane = {pkgs, ...}: {
    home.packages = [pkgs.shikane];

    # Shikane picks the first profile whose outputs all match the currently
    # connected displays. Match is strict: every profile output must find a
    # display and every connected display must be matched by some output.
    # `s=...` matches by serial (survives DP port swaps), `n=...` matches by
    # connector name. Positions are in logical (post-scale) pixels, same
    # convention as niri's native `output { position ... }`.
    xdg.configFile."shikane/config.toml".text = ''
      # --- Desktop (slh-pc): two monitors ---
      # [[profile]]
      # name = "desktop"
      #
      # [[profile.output]]
      # search = ["s=DESKTOP_LEFT_SERIAL"]
      # enable = true
      # position = "0,0"
      # scale = 1.0
      #
      # [[profile.output]]
      # search = ["s=DESKTOP_RIGHT_SERIAL"]
      # enable = true
      # position = "2560,0"
      # scale = 1.0

      # --- Laptop at work: two LG 4K + eDP-1 centered below ---
      [[profile]]
      name = "laptop-work"

      [[profile.output]]
      search = ["s=408NTYT1A610"]
      enable = true
      position = "0,0"
      scale = 1.25

      [[profile.output]]
      search = ["s=408NTSU1A686"]
      enable = true
      position = "3072,0"
      scale = 1.25

      [[profile.output]]
      search = ["n=eDP-1"]
      enable = true
      position = "2250,1728"
      scale = 1.75

      # --- Laptop at home: two externals, internal off ---
      # [[profile]]
      # name = "laptop-home"
      #
      # [[profile.output]]
      # search = ["s=HOME_LEFT_SERIAL"]
      # enable = true
      # position = "0,0"
      # scale = 1.0
      #
      # [[profile.output]]
      # search = ["s=HOME_RIGHT_SERIAL"]
      # enable = true
      # position = "1920,0"
      # scale = 1.0
      #
      # [[profile.output]]
      # search = ["n=eDP-1"]
      # enable = false

      # --- Laptop alone: only internal panel ---
      [[profile]]
      name = "laptop-alone"

      [[profile.output]]
      search = ["n=eDP-1"]
      enable = true
      position = "0,0"
      scale = 1.75
    '';

    systemd.user.services.shikane = {
      Unit = {
        Description = "shikane dynamic output configuration";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session.target"];
        Requisite = ["graphical-session.target"];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.shikane}/bin/shikane";
        Restart = "on-failure";
        RestartSec = 2;
      };
      Install.WantedBy = ["niri.service"];
    };
  };
}
