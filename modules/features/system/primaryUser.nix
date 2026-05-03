{lib, ...}: {
  flake.modules.nixos.primaryUser = {
    options.slh.primaryUser = lib.mkOption {
      type = lib.types.str;
      default = "slh";
      description = ''
        Login name of the primary user. Used by `users.users.<n>` creation
        in user.nix and by every `home-manager.users.<n>` binding across
        feature modules. Override per host (e.g. ISO) to retarget all
        bindings to a different account without forking the modules.
      '';
    };
  };
}
