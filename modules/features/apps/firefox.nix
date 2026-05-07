{self, ...}: {
  flake.modules.nixos.firefox = {
    # environment.systemPackages = [pkgs.firefox];

    slh.userHomeModules.firefox = self.modules.homeManager.firefox;
  };

  flake.modules.homeManager.firefox = {
    pkgs,
    config,
    ...
  }: {
    programs.firefox = {
      enable = true;
      configPath = "${config.xdg.configHome}/mozilla/firefox";

      # Lock-down policies. Search engines are intentionally NOT here —
      # mixing policies.SearchEngines.* with profiles.<n>.search.engines
      # produces conflicting state. Engines live in the profile below.
      policies = {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableFirefoxAccounts = true;
        DisableFirefoxStudies = true;
        DisableFormHistory = true;
        DisableMasterPasswordCreation = true;
        DisableProfileImport = true;
        DisableSetDesktopBackground = true;
        DisableTelemetry = true;
        DisplayBookmarksToolbar = "newtab";
        EnableTrackingProtection = {
          Category = "strict";
          Cryptomining = true;
          EmailTracking = true;
          Fingerprinting = true;
          SuspectedFingerprinting = true;
          Value = true;
        };
        ExtensionSettings = {
          # uBlock Origin
          "uBlock0@raymondhill.net" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            private_browsing = true;
          };
          # Bitwarden
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            private_browsing = true;
            default_area = "navbar";
          };
          # Vimium
          "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
            private_browsing = true;
            default_area = "navbar";
          };
        };
        FirefoxHome = {
          Highlights = false;
          Search = true;
          SponsoredStories = false;
          SponsoredTopSites = false;
          Stories = false;
          TopSites = false;
        };
        FirefoxSuggest = {
          ImproveSuggest = false;
          SponsoredSuggestions = false;
          WebSuggestions = false;
        };
        GenerativeAI.Enabled = false;
        HardwareAcceleration = true;
        HttpsOnlyMode = "enabled";
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        PasswordManagerEnabled = false;
        PictureInPicture.Enabled = true;
        PopupBlocking.Default = true;
        PrimaryPassword = false;
        SearchBar = "unified";
        SearchSuggestEnabled = false;
        SkipTermsOfUse = true;
      };

      profiles.default = {
        isDefault = true;

        settings = {
          "general.autoScroll" = true;
          "nimbus.rollouts.enabled" = false;
          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;
          "sidebar.visibility" = "always-show";
          "browser.startup.page" = 3;
          "browser.tabs.warnOnClose" = true;
          "browser.tabs.firefox-view" = false;
          "browser.tabs.tabmanager.enabled" = false;
          "browser.tabs.inTitlebar" = 0;
          "browser.ai.control.default" = "blocked";
          "browser.ai.control.smartTabGroups" = "enabled";

          "browser.uiCustomization.state" = builtins.toJSON {
            placements = {
              widget-overflow-fixed-list = [];
              unified-extensions-area = [];
              nav-bar = [
                "back-button"
                "forward-button"
                "stop-reload-button"
                "urlbar-container"
                "unified-extensions-button"
                "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action" # Bitwarden
                "ublock0_raymondhill_net-browser-action" # uBlock
                "_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action" # Vimium
                "downloads-button"
              ];
              toolbar-menubar = ["menubar-items"];
              TabsToolbar = [];
              vertical-tabs = ["tabbrowser-tabs"];
              PersonalToolbar = ["personal-bookmarks"];
            };
            seen = [
              "developer-button"
              "_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action"
              "ublock0_raymondhill_net-browser-action"
              "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
              "screenshot-button"
              "stop-reload-button"
            ];
            dirtyAreaCache = ["nav-bar" "TabsToolbar" "vertical-tabs"];
            currentVersion = 23;
            newElementCount = 0;
          };
        };

        search = {
          force = true; # prevents Firefox from overwriting search engines
          default = "kagi";

          engines = {
            kagi = {
              name = "Kagi";
              urls = [{template = "https://kagi.com/search?q={searchTerms}";}];
              iconMapObj."16" = "https://kagi.com/asset/6320cc1/kagi_assets/logos/search.svg";
              definedAliases = ["@k"];
            };
            arch-wiki = {
              name = "Arch Wiki";
              urls = [{template = "https://wiki.archlinux.org/index.php?search={searchTerms}";}];
              iconMapObj."16" = "https://wiki.archlinux.org/favicon.ico";
              definedAliases = ["@aw"];
            };
            docker-hub = {
              name = "Docker Hub";
              urls = [{template = "https://hub.docker.com/search?q={searchTerms}";}];
              iconMapObj."16" = "https://hub.docker.com/favicon.ico";
              definedAliases = ["@dh"];
            };
            flathub = {
              name = "Flathub";
              urls = [{template = "https://flathub.org/apps/search?q={searchTerms}";}];
              iconMapObj."16" = "https://flathub.org/favicon.png";
              definedAliases = ["@fh"];
            };
            github = {
              name = "GitHub";
              urls = [{template = "https://github.com/search?q={searchTerms}";}];
              iconMapObj."16" = "https://github.com/favicon.ico";
              definedAliases = ["@gh"];
            };
            home-manager = {
              name = "Home Manager";
              urls = [{template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=release-25.11";}];
              iconMapObj."16" = "https://home-manager-options.extranix.com/images/favicon.png";
              definedAliases = ["@hm"];
            };
            nixos-options = {
              name = "NixOS Options";
              urls = [{template = "https://search.nixos.org/options?channel=25.11&query={searchTerms}";}];
              iconMapObj."16" = "https://search.nixos.org/favicon.png";
              definedAliases = ["@no"];
            };
            nixos-packages = {
              name = "NixOS Packages";
              urls = [{template = "https://search.nixos.org/packages?channel=25.11&query={searchTerms}";}];
              iconMapObj."16" = "https://search.nixos.org/favicon.png";
              definedAliases = ["@np"];
            };
            nixos-wiki = {
              name = "NixOS Wiki";
              urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
              iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
              definedAliases = ["@nw"];
            };
            protondb = {
              name = "ProtonDB";
              urls = [{template = "https://www.protondb.com/search?q={searchTerms}";}];
              iconMapObj."16" = "https://www.protondb.com/favicon.ico";
              definedAliases = ["@pd"];
            };
            reddit = {
              name = "Reddit";
              urls = [{template = "https://www.reddit.com/search/?q={searchTerms}";}];
              iconMapObj."16" = "https://www.reddit.com/favicon.ico";
              definedAliases = ["@rd"];
            };
            stackoverflow = {
              name = "Stack Overflow";
              urls = [{template = "https://stackoverflow.com/search?q={searchTerms}";}];
              iconMapObj."16" = "https://stackoverflow.com/favicon.ico";
              definedAliases = ["@so"];
            };

            # Hide built search engines
            "amazondotcom-us".metaData.hidden = true;
            "bing".metaData.hidden = true;
            "ebay".metaData.hidden = true;
            "perplexity".metaData.hidden = true;
          };
        };
      };
    };

    home.sessionVariables = {
      BROWSER = "firefox";
    };

    # Configure XDG MIME types to route all web traffic to Firefox
    xdg.mimeApps = {
      enable = true;

      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
        # "application/pdf" = "firefox.desktop";
      };
    };
  };
}
