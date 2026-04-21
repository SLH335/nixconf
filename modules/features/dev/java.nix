{...}: {
  flake.nixosModules.java = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      jdk25
    ];
  };
}
