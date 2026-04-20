{self, ...}: {
  flake.nixosModules.firefox = {pkgs, ...}: {
    environment.systemPackages = [pkgs.firefox];

    home-manager.users.slh = self.homeModules.firefox;
  };

  flake.homeModules.firefox = {pkgs, ...}: {
    programs.firefox = {
      enable = true;
      policies = {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        # Cookies.Behavior = "reject-tracker-and-partition-foreign";
        # DisableBuiltinPDFViewer = true;
        DisableFirefoxAccounts = true;
        DisableFirefoxStudies = true;
        DisableFormHistory = true;
        DisableMasterPasswordCreation = true;
        DisableProfileImport = true;
        DisableSetDesktopBackground = true;
        DisableTelemetry = true;
        DisplayBookmarksToolbar = "newtab";
        # DisplayMenuBar = "default-off";
        # DNSOverHTTPS.Enabled = false;
        EnableTrackingProtection = {
          Category = "strict";
          Cryptomining = true;
          EmailTracking = true;
          Fingerprinting = true;
          SuspectedFingerprinting = true;
          Value = true;
        };
        # EncryptedMediaExtensions.Enabled = true;
        ExtensionSettings = {
          "uBlock0@raymondhill.net" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            private_browsing = true;
          };
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            private_browsing = true;
          };
          "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
            private_browsing = true;
          };
        };
        FirefoxHome = {
          Highlights = false;
          Search = true;
          SponsoredStories = false;
          SponsoredTopSites = false;
          Stories = false;
          TopSites = true;
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
        # Permissions = {
        #   Autoplay.Default = "block-audio";
        #   Camera.BlockNewRequests = true;
        #   Location.BlockNewRequests = true;
        #   Microphone.BlockNewRequests = true;
        #   Notifications.BlockNewRequests = true;
        #   ScreenShare.BlockNewRequests = true;
        #   VirtualReality.BlockNewRequests = true;
        # };
        PictureInPicture.Enabled = true;
        PopupBlocking.Default = true;
        PrimaryPassword = false;
        SearchBar = "unified";
        SearchEngines.Add = [
          {
            Name = "Kagi";
            Alias = "@k";
            URLTemplate = "https://kagi.com/search?q={searchTerms}";
            IconURL = "https://kagi.com/asset/6320cc1/kagi_assets/logos/search.svg";
          }
          {
            Name = "Arch Wiki";
            Alias = "@aw";
            URLTemplate = "https://wiki.archlinux.org/index.php?search={searchTerms}";
            IconURL = "https://wiki.archlinux.org/favicon.ico";
          }
          {
            Name = "Docker Hub";
            Alias = "@dh";
            URLTemplate = "https://hub.docker.com/search?q={searchTerms}";
            IconURL = "https://hub.docker.com/favicon.ico";
          }
          {
            Name = "Flathub";
            Alias = "@fh";
            URLTemplate = "https://flathub.org/apps/search?q={searchTerms}";
            IconURL = "https://flathub.org/favicon.png";
          }
          {
            Name = "GitHub";
            Alias = "@gh";
            URLTemplate = "https://github.com/search?q={searchTerms}";
            IconURL = "https://github.com/favicon.ico";
          }
          {
            Name = "Home Manager";
            Alias = "@hm";
            URLTemplate = "https://home-manager-options.extranix.com/?query={searchTerms}&release=release-25.11";
            IconURL = "https://home-manager-options.extranix.com/images/favicon.png";
          }
          {
            Name = "NixOS Options";
            Alias = "@no";
            URLTemplate = "https://search.nixos.org/options?channel=25.11&query={searchTerms}";
            IconURL = "https://search.nixos.org/favicon.png";
          }
          {
            Name = "NixOS Packages";
            Alias = "@np";
            URLTemplate = "https://search.nixos.org/packages?channel=25.11&query={searchTerms}";
            IconURL = "https://search.nixos.org/favicon.png";
          }
          {
            Name = "NixOS Wiki";
            Alias = "@nw";
            URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
            IconURL = "https://wiki.nixos.org/favicon.ico";
          }
          {
            Name = "ProtonDB";
            Alias = "@pd";
            URLTemplate = "https://www.protondb.com/search?q={searchTerms}";
            IconURL = "https://www.protondb.com/favicon.ico";
          }
          {
            Name = "Reddit";
            Alias = "@rd";
            URLTemplate = "https://www.reddit.com/search/?q={searchTerms}";
            IconURL = "https://www.reddit.com/favicon.ico";
          }
          {
            Name = "Stack Overflow";
            Alias = "@so";
            URLTemplate = "https://stackoverflow.com/search?q={searchTerms}";
            IconURL = "https://stackoverflow.com/favicon.ico";
          }
          {
            Name = "Wikipedia";
            Alias = "@wk";
            URLTemplate = "https://en.wikipedia.org/wiki/Special:Search?search={searchTerms}";
            IconURL = "https://en.wikipedia.org/static/favicon/wikipedia.ico";
          }
        ];
        SearchEngines.Remove = [
          "Amazon.com"
          "Bing"
          "eBay"
          "Perplexity"
          "Wikipedia (en)"
        ];
        SearchEngines.Default = "Kagi";
        SearchSuggestEnabled = false;
        # ShowHomeButton = true;
        SkipTermsOfUse = true;
        # TranslateEnabled = true;
      };
      profiles.default = {
        isDefault = true;

        settings = {
          # Enable the new sidebar framework
          "sidebar.revamp" = true;

          # Turn on vertical tabs natively
          "sidebar.verticalTabs" = true;

          # Optional: Force the sidebar to always be visible on startup
          "sidebar.visibility" = "always";

          # Resume previous browser session
          "browser.startup.page" = 3;

          # Optional: Warn when quitting a window with multiple tabs
          "browser.tabs.warnOnClose" = true;

          # Remove "View recent browsing..." (Firefox View)
          "browser.tabs.firefox-view" = false;

          # Remove "List all tabs" (The dropdown arrow)
          "browser.tabs.tabmanager.enabled" = false;

          # Disable Firefox's native window controls
          "browser.tabs.inTitlebar" = 0;
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
