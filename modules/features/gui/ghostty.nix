{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.ghostty = {...}: {
    home-manager.users.slh = self.homeModules.ghostty;

    systemd.user.services.ghostty = {
      enable = true;
      # run it with `ghostty --gtk-single-instance=true`
    };
  };

  flake.homeModules.ghostty = {...}: {
    programs.ghostty = {
      enable = true;

      # Automatically enable shell integrations (pick your shell)
      enableZshIntegration = true;

      # This creates $XDG_CONFIG_HOME/ghostty/config
      settings = {
        theme = "Catppuccin Mocha";
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
