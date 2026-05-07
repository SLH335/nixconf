{...}: {
  flake.modules.nixos.keyring = {lib, ...}: {
    services.gnome.gnome-keyring.enable = lib.mkForce false;
    services.gnome.gcr-ssh-agent.enable = false;
  };
}
