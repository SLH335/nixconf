{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.apps = {config, ...}: {
    home-manager.users.${config.slh.primaryUser} = self.modules.homeManager.apps;
  };

  flake.modules.homeManager.apps = {pkgs, ...}: {
    home.packages = with pkgs; [
      zathura
      grayjay
      gimp
      picard
      signal-desktop
      telegram-desktop
      brave
      tor-browser
      nerd-fonts.jetbrains-mono
      pdfarranger
      networkmanagerapplet

      inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
