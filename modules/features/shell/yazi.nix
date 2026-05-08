{self, ...}: {
  flake.modules.nixos.yazi = {pkgs, ...}: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.yazi
    ];

    slh.userHomeModules.yazi = {pkgs, ...}: {
      # `y` shell wrapper: launches yazi, captures cwd on exit, and cd's
      # the parent shell to that directory. Lives in HM because zshrc is
      # the only place this hook is meaningful — wrapper can't inject
      # functions into the user's shell environment.
      programs.zsh.initContent = ''
        function y() {
          local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
          ${pkgs.lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.yazi} "$@" --cwd-file="$tmp"
          if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
          fi
          rm -f -- "$tmp"
        }
      '';
    };
  };
}
