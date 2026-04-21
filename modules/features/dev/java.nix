{...}: {
  flake.modules.nixos.java = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      jdk25
    ];
  };
}
