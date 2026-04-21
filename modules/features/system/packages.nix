{...}: {
  flake.modules.nixos.packages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      vim
      cryptsetup
      wireguard-tools
      killall
    ];
  };
}
