{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.pcConfiguration = {
    config,
    lib,
    pkgs,
    ...
  }: {
    imports = [
      inputs.home-manager.nixosModules.default
      inputs.nvf.nixosModules.default

      self.nixosModules.pcHardwareConfiguration
      self.nixosModules.bootloader
      self.nixosModules.home

      self.nixosModules.niri
      self.nixosModules.shikane
      self.nixosModules.noctalia
      self.nixosModules.greetd
      self.nixosModules.git

      self.nixosModules.ghostty
      self.nixosModules.shell
      self.nixosModules.cli
      self.nixosModules.neovim
      self.nixosModules.yazi
      self.nixosModules.atuin
      self.nixosModules.zellij
      self.nixosModules.zoxide
      self.nixosModules.btop

      self.nixosModules.firefox
      self.nixosModules.imv
      self.nixosModules.mpv
      self.nixosModules.steam
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];

    networking.hostName = "slh-pc"; # Define your hostname.
    networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

    # Set your time zone.
    time.timeZone = "Europe/Berlin";
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.slh = {
      isNormalUser = true;
      description = "SLH";
      extraGroups = ["wheel" "networkmanager"];
      shell = pkgs.zsh;
      home = "/home/slh";
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile.
    # You can use https://search.nixos.org/ to find more packages (and options).
    environment.systemPackages = with pkgs; [
      vim
      jdk25
      wdisplays
      signal-desktop
      nerd-fonts.jetbrains-mono

      cryptsetup
      wireguard-tools
      killall
    ];

    hardware.bluetooth.enable = true;

    # Enable desktop portals
    xdg.portal = {
      enable = true;
      # Optional: this can help xdg-open use a portal
      xdgOpenUsePortal = true;

      # Make sure to include at least the GTK portal and the Hyprland portal
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];

      # Optional: portal order and defaults
      config = {
        common.default = ["gnome" "gtk"];
        # hyprland.default = ["gtk" "hyprland"];
        niri.default = ["gnome" "gtk"];
      };
    };

    # If you use sessionVariables from NixOS:
    environment.sessionVariables = {
      # Qt/Electron apps want this
      NIXOS_OZONE_WL = "1";
      # XDG_CURRENT_DESKTOP = "Hyprland";
    };

    # security.rtkit.enable = true;

    # Ensures that portal definitions get linked into your store profile
    # environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
    # List services that you want to enable:

    services.upower.enable = true;

    services.greetd.settings.initial_session = {
      command = "niri-session";
      user = "slh";
    };

    # services.flatpak.enable = true;

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "25.05"; # Did you read the comment?
  };
}
