{...}: {
  flake.modules.nixos.bootloader = {pkgs, ...}: {
    boot = {
      loader.systemd-boot = {
        enable = true;
        consoleMode = "max";
        configurationLimit = 20;
      };
      loader.efi.canTouchEfiVariables = true;
      plymouth = {
        enable = true;
        theme = "breeze";
      };

      initrd.systemd.enable = true;

      consoleLogLevel = 0;
      initrd.verbose = false;

      kernelParams = [
        "quiet"
        "splash"
      ];

      supportedFilesystems = ["nfs"];

      # Use latest kernel.
      kernelPackages = pkgs.linuxPackages_latest;
    };
  };
}
