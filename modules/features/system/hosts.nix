{lib, ...}: {
  options.flake.hosts = lib.mkOption {
    default = {};
    description = ''
      Registry of every machine in the fleet. Each host's `default.nix`
      contributes its own row; the `sshFleet` consumer reads the whole
      attrset to populate `services.openssh.knownHosts` and
      `users.users.<primaryUser>.openssh.authorizedKeys.keys`.

      Set `publicKey = null` while bootstrapping; null entries are
      skipped from knownHosts so the build doesn't fail on placeholders.
    '';
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        publicKey = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = ''
            Contents of `/etc/ssh/ssh_host_ed25519_key.pub` on this host.
            `null` means "not yet captured" — entry is skipped from
            knownHosts on consumers until populated.
          '';
        };

        role = lib.mkOption {
          type = lib.types.enum ["desktop" "server" "untrusted"];
          description = ''
            Trust tier. Hosts whose `authorizesRoles` includes this role
            will receive this host's `userKeys` in their authorized_keys.
          '';
        };

        addresses = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [];
          description = ''
            Extra hostnames/aliases that should match this host's pubkey
            in known_hosts (Tailscale FQDNs, LAN IPs, etc.). The attrset
            key is always included automatically.
          '';
        };

        userKeys = lib.mkOption {
          type = lib.types.attrsOf lib.types.str;
          default = {};
          description = ''
            User-level public keys this host contributes to the fleet.
            Authorized on hosts whose `authorizesRoles` includes this
            host's role. Servers/untrusted hosts typically leave empty.
          '';
        };

        authorizesRoles = lib.mkOption {
          type = lib.types.listOf (lib.types.enum ["desktop" "server" "untrusted"]);
          default = ["desktop"];
          description = ''
            Roles whose userKeys get authorized on this host. Default
            (`["desktop"]`) means: only desktops can SSH in. Add `"server"`
            if a specific server should pull from another, etc.
          '';
        };
      };
    });
  };
}
