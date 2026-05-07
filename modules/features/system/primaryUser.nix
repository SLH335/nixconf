{lib, ...}: {
  flake.modules.nixos.primaryUser = {
    options.slh.primaryUser = lib.mkOption {
      type = lib.types.str;
      description = ''
        Login name of the primary user on this host. Set by the imported
        user module (e.g. userSlh, userIso) via mkDefault. Read by host
        configs that need to name the primary user, such as greetd
        autologin.
      '';
    };
  };
}
