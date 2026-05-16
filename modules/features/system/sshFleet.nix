{
  self,
  lib,
  ...
}: {
  flake.modules.nixos.sshFleet = {config, ...}: let
    hostName = config.networking.hostName;
    me = self.hosts.${hostName} or null;

    # Skip entries with no captured pubkey so placeholder hosts don't
    # break the build before each machine has been visited.
    hostsWithKey = lib.filterAttrs (_: h: h.publicKey != null) self.hosts;
  in {
    services.openssh.knownHosts =
      lib.mapAttrs (name: host: {
        hostNames = [name] ++ host.addresses;
        publicKey = host.publicKey;
      })
      hostsWithKey;

    users.users.${config.slh.primaryUser}.openssh.authorizedKeys.keys = lib.optionals (me != null) (
      lib.concatLists (lib.mapAttrsToList
        (_: other:
          if lib.elem other.role me.authorizesRoles
          then lib.attrValues other.userKeys
          else [])
        self.hosts)
    );

    slh.userHomeModules.sshFleet = self.modules.homeManager.sshFleet;
  };

  flake.modules.homeManager.sshFleet = {osConfig, ...}: let
    hostName = osConfig.networking.hostName;
    me = self.hosts.${hostName} or null;
    primaryUser = osConfig.slh.primaryUser;

    # `ssh <hostname>` shorthand for every fleet member: fills in the
    # custom server port and primary user from registry data. Servers
    # carry no userKeys (and so can't authenticate outward), making this
    # shorthand desktop-only by intent — keyed off the current host's
    # role rather than maintaining a parallel opt-in list.
    fleetBlocks = lib.optionalAttrs (me != null && me.role == "desktop") (
      lib.mapAttrs (_: _: {
        port = 5432;
        user = primaryUser;
      })
      self.hosts
    );
  in {
    programs.ssh = {
      enable = true;

      # Opt out of home-manager's legacy top-level defaults (forwardAgent,
      # compression, serverAlive*, etc.) — they're being removed in a
      # future release. We set what we want explicitly under matchBlocks
      # below; everything else falls through to OpenSSH's own defaults.
      enableDefaultConfig = false;

      matchBlocks =
        fleetBlocks
        // {
          # Defensive default: never forward the agent. A compromised remote
          # host with ForwardAgent=yes can ask the local agent to sign for
          # any loaded key, including the Nitrokey-resident one. To override
          # for a specific host that genuinely needs agent forwarding, add
          # a matchBlocks entry with `forwardAgent = true;` — but prefer
          # ProxyJump (`ssh -J jump target`) instead, which keeps the agent
          # off the wire entirely.
          "*".extraOptions.ForwardAgent = "no";
        };
    };
  };
}
