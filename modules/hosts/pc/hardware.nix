{...}: {
  flake.modules.nixos.pcHardwareConfiguration = {
    config,
    lib,
    pkgs,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-amd"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/mapper/cryptroot";
      fsType = "btrfs";
      options = ["subvol=@root"];
    };

    boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/5f2b334a-8287-4eec-8908-980a7f0ddfab";

    fileSystems."/home" = {
      device = "/dev/mapper/cryptroot";
      fsType = "btrfs";
      options = ["subvol=@home"];
    };

    fileSystems."/nix" = {
      device = "/dev/mapper/cryptroot";
      fsType = "btrfs";
      options = ["subvol=@nix"];
    };

    fileSystems."/swap" = {
      device = "/dev/mapper/cryptroot";
      fsType = "btrfs";
      options = ["subvol=@swap"];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/D4B2-EA69";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    swapDevices = [];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
