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
  };
}
