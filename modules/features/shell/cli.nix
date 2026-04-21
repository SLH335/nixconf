{self, ...}: {
  flake.modules.nixos.cli = {...}: {
    home-manager.users.slh = self.modules.homeManager.cli;
  };

  flake.modules.homeManager.cli = {pkgs, ...}: {
    catppuccin.bat.enable = true;
    catppuccin.lsd.enable = true;

    home.packages = with pkgs; [
      wget
      ripgrep
      dust
      xh
      prettyping
      wl-clipboard
      trashy
    ];

    programs.bat.enable = true;

    programs.lsd = {
      enable = true;
      # Automatically sets up 'ls', 'll', 'la', 'lla', to use lsd in ZSH
      enableZshIntegration = true;
    };

    programs.fd = {
      enable = true;
      hidden = true; # Search hidden files by default
    };

    programs.zsh = {
      shellAliases = {
        ip = "ip -c";
        grep = "grep --color=auto";

        cat = "bat";
        ping = "prettyping --nolegend";
      };
    };
  };
}
