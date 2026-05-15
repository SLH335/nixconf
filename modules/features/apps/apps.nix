{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.apps = {
    slh.userHomeModules.apps = self.modules.homeManager.apps;
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
      anki

      inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
