{self, ...}: {
  flake.modules.nixos.desktopBundle = {
    imports = with self.modules.nixos; [
      greetd
      niri
      noctalia
      shikane
      theme
      wayland
    ];
  };
}
