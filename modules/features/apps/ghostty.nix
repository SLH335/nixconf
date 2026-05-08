{
  self,
  lib,
  ...
}: {
  flake.modules.nixos.ghostty = {
    pkgs,
    config,
    ...
  }: let
    wrappedGhostty = self.mkGhostty pkgs {inherit (config.slh.ghostty) fontSize;};
  in {
    options.slh.ghostty.fontSize = lib.mkOption {
      type = lib.types.int;
      default = 14;
      description = ''
        Font size for the wrapped ghostty terminal. Override per host.
      '';
    };

    config = {
      environment.systemPackages = [wrappedGhostty];

      slh.userHomeModules.ghostty = {...}: {
        # Ghostty's full config (font, theme, padding, keybinds) is baked into
        # the wrapper at modules/wrappers/ghostty.nix. The only thing left for
        # HM is the zsh shell-integration source line, which has to live in
        # the user's zshrc and can't be wrapped into the binary.
        programs.zsh.initContent = ''
          if [[ "$TERM" == "xterm-ghostty" ]]; then
            builtin source ${wrappedGhostty}/share/ghostty/shell-integration/zsh/ghostty-integration
          fi
        '';
      };

      systemd.user.services.ghostty.enable = true;
    };
  };
}
