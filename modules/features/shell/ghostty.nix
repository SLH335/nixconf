{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.ghostty = {...}: {
    home-manager.users.slh = self.modules.homeManager.ghostty;

    systemd.user.services.ghostty = {
      enable = true;
      # run it with `ghostty --gtk-single-instance=true`
    };
  };

  flake.modules.homeManager.ghostty = {...}: {
    catppuccin.ghostty.enable = true;

    programs.ghostty = {
      enable = true;

      # Automatically enable shell integrations (pick your shell)
      enableZshIntegration = true;

      # This creates $XDG_CONFIG_HOME/ghostty/config
      settings = {
        font-family = "JetBrainsMono Nerd Font";
        font-size = 14;
        window-padding-x = 10;
        window-padding-y = 10;
        window-decoration = false;
        background-opacity = 0.9;
        background-blur-radius = 20;
        # Keybinds can be defined as a list for duplicate keys
        keybind = [
          "ctrl+h=goto_split:left"
          "ctrl+l=goto_split:right"
        ];
      };
    };
  };
}
