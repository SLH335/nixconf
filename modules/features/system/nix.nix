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
}
