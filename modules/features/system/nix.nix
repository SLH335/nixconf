{inputs, ...}: {
  flake.nixosModules.nix = {
    imports = [
      inputs.nix-index-database.nixosModules.default
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];
    nixpkgs.config.allowUnfree = true;

    programs.nix-index-database.comma.enable = true;
  };
}
