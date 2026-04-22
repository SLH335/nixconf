{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.home = {
    imports = [
      inputs.home-manager.nixosModules.default
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.slh = self.modules.homeManager.home;
    };
  };

  flake.modules.homeManager.home = {pkgs, ...}: {
    programs.home-manager.enable = true;

    home.username = "slh";
    home.homeDirectory = "/home/slh";

    home.packages = with pkgs; [
      signal-desktop
      telegram-desktop
      brave
      tor-browser
      nerd-fonts.jetbrains-mono
      fastfetch
      pdfarranger
      networkmanagerapplet
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
