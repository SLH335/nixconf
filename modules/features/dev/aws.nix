{...}: {
  flake.modules.nixos.aws = {pkgs, ...}: let
    aws-runas = pkgs.buildGoModule rec {
      pname = "aws-runas";
      version = "3.7.0"; # Latest version as of current writing

      src = pkgs.fetchFromGitHub {
        owner = "mmmorris1975";
        repo = "aws-runas";
        rev = "${version}";
        # We use a fake hash initially. Nix will tell us the real one.
        hash = "sha256-7nrZYcx36Vu5jnvtWS1geC/oJzY2bBFyZ0BTOBhlmHk=";
      };

      # Go modules require a separate hash for their dependencies.
      vendorHash = "sha256-UOCEqeekvutanYTNCPpTUG/FICTdBbAskPhPsdtcLJs=";

      # We disable tests because some aws-runas tests attempt network
      # calls or require AWS environments, which will fail inside the Nix build sandbox.
      doCheck = false;
    };
  in {
    # {
    environment.systemPackages = with pkgs; [
      awscli2
      aws-runas
      chromium
    ];
  };
}
