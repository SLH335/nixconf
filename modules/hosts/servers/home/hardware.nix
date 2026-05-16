{...}: {
  flake.modules.nixos.server2HardwareConfiguration = {
    config,
    lib,
    pkgs,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = ["xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = [];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/42dfcb82-5011-423e-bb9e-1f1814675723";
      fsType = "btrfs";
      options = ["subvol=@root"];
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/42dfcb82-5011-423e-bb9e-1f1814675723";
      fsType = "btrfs";
      options = ["subvol=@home"];
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/42dfcb82-5011-423e-bb9e-1f1814675723";
      fsType = "btrfs";
      options = ["subvol=@nix"];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/66A0-76FE";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    swapDevices = [];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
