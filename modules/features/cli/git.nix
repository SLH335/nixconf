{self, ...}: {
  flake.nixosModules.git = {pkgs, ...}: {
    environment.systemPackages = [pkgs.git];

    home-manager.users.slh = self.homeModules.git;
  };

  flake.homeModules.git = {...}: {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = "SLH";
          email = "git@slh.dev";
        };
      };
    };

    programs.ssh = {
      matchBlocks."github.com" = {
        user = "git";
        identityFile = "~/.ssh/id_ed25519_sk";
        identitiesOnly = true;

        extraOptions = {
          IdentityAgent = "none";
        };
      };
    };

    programs.zsh = {
      shellAliases = {
        gs = "git status";
        gd = "git diff";
        gl = "git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit";
        gc = "git commit";
        gca = "git commit --amend";
        ga = "git add";
        gap = "git add -p";
        gp = "git push";
        gpl = "git pull";
        gco = "git checkout";
      };
    };
  };
}
