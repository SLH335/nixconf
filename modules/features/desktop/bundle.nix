{self, ...}: {
  flake.nixosModules.desktopBundle = {
    imports = with self.nixosModules; [
      greetd
      niri
      noctalia
      shikane
      theme
      wayland
    ];
  };
}
