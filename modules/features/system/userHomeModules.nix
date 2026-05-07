{lib, ...}: {
  flake.modules.nixos.userHomeModules = {
    options.slh.userHomeModules = lib.mkOption {
      type = lib.types.attrsOf lib.types.deferredModule;
      default = {};
      description = ''
        Registry of home-manager modules contributed by feature modules.
        The active user module (e.g. userSlh) imports the values into the
        primary user's home-manager profile. Lets feature modules opt in
        to home-manager without naming a user.
      '';
    };
  };
}
