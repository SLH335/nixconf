{inputs, ...}: {
  flake.modules.nixos.nix = {
    imports = [
      inputs.nix-index-database.nixosModules.default
    ];

    nix = {
      settings.experimental-features = ["nix-command" "flakes"];

      optimise = {
        automatic = true;
        dates = ["weekly"];
      };
    };

    nixpkgs.config.allowUnfree = true;

    programs.nix-index-database.comma.enable = true;
  };

  # flake-parts instantiates its own `pkgs` for `perSystem`, separate from the
  # NixOS `pkgs`, so `nixpkgs.config.allowUnfree` set above does not apply to
  # wrapper packages built in `perSystem`. Re-import nixpkgs with unfree
  # allowed so wrappers can reference unfree pkgs (steam, etc.).
  perSystem = {system, ...}: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  };
}
