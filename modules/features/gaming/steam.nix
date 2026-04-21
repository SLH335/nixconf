{...}: {
  flake.modules.nixos.steam = {pkgs, ...}: {
    hardware.graphics.enable = true;

    programs = {
      steam = {
        enable = true;

        package = pkgs.steam.override {
          extraArgs = "-system-composer";
        };
      };
      gamescope.enable = true;
    };

    environment.systemPackages = with pkgs; [
      gamescope
    ];
  };
}
