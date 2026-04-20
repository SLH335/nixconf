{self, ...}: {
  flake.nixosModules.home = {
    home-manager.users.slh = self.homeModules.home;
  };

  flake.homeModules.home = {
    pkgs,
    inputs,
    ...
  }: {
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    nixpkgs.config.allowUnfree = true;

    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "slh";
    home.homeDirectory = "/home/slh";

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = with pkgs; [
      signal-desktop
      telegram-desktop
      brave
      tor-browser
      nerd-fonts.jetbrains-mono
      fastfetch
      pdfarranger
      networkmanagerapplet
      cursor-cli
      code-cursor-fhs
      ngrok
      pnpm
      nodejs
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "25.11"; # Please read the comment before changing.
  };
}
