{...}: {
  flake.modules.nixos.howdy = {...}: {
    services.howdy = {
      enable = true;
      control = "sufficient";
      settings.video.device_path = "/dev/video2";
    };

    security.pam.services.polkit-1.howdy.enable = false;
  };
}
