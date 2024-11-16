{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let

    user = builtins.toString (builtins.exec "whoami" []);

    flake_device = builtins.getEnv "flake_device" or "macbook";

    brewCasks = builtins.splitString "\n" (builtins.readFile ./brew_casks.txt);

    brewFormulae = builtins.splitString "\n" (builtins.readFile ./brew_formulae.txt);

    configuration = { pkgs, ... }: {
      
      # READ: https://mynixos.com/nix-darwin/option/environment.shellAliases
      # environment.shellAliases = {};

      homebrew = {
        enable = true;
        brews = brewFormulae;
        casks = brewCasks;

        # install apps from App Store
        # READ: https://mynixos.com/nix-darwin/option/homebrew.masApps
        # masApps = [];
        
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };


      #DOCS: https://mynixos.com/options
      security.pam.enableSudoTouchIdAuth = true;
      system.startup.chime = false;

      # READ: https://macos-defaults.com/
      # SYNTAX DOCS: https://mynixos.com/options/system.defaults
      system.defaults = {
        dock.mineffect = "scale";
        hitoolbox.AppleFnUsageType = "Show Emoji & Symbols";
        screencapture.include-date = false;
        SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
        screensaver.askForPasswordDelay = 1;
        screensaver.askForPassword = true;
        screencapture.type = "jpg";
        screencapture.location = "~/Screenshots";
        screencapture.disable-shadow = true;
        NSGlobalDomain.KeyRepeat = 2;
        NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
        NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
        NSGlobalDomain.NSAutomaticInlinePredictionEnabled = false;
        NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
        NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
        NSGlobalDomain.AppleShowScrollBars = "Always";
        NSGlobalDomain.AppleShowAllFiles = true;
        NSGlobalDomain.AppleScrollerPagingBehavior = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain.AppleICUForce24HourTime = true;
        menuExtraClock.ShowSeconds = true;
        menuExtraClock.ShowDayOfWeek = true;
        menuExtraClock.ShowDate = 1;
        menuExtraClock.ShowAMPM = false;
        menuExtraClock.Show24Hour = true;
        WindowManager.EnableStandardClickToShowDesktop = false;
        loginwindow.GuestEnabled = false;
        finder.FXDefaultSearchScope = "SCcf";
        finder.FXPreferredViewStyle = "Nlsv";
        finder.ShowPathbar = true;
        finder.ShowStatusBar = true;
        dock.autohide = true;
        dock.autohide-delay = 0.0;
        dock.autohide-time-modifier = 0.0;
        dock.minimize-to-application = true;
        dock.mru-spaces = false;
        dock.orientation = "left";
        dock.show-recents = false;
        dock.showhidden = true;
        dock.persistent-apps = [
          "/Applications/1Password.app"
          "/Applications/LibreWolf.app"
          "/Applications/Spark Desktop.app"
          "/Applications/Discord.app"
          "/Applications/Viber.app"
          "/Applications/Slack.app"
          "/Applications/Spotify.app"
          "/Applications/Visual Studio Code.app"
          "/Applications/PyCharm CE.app"
          "/Applications/CLion.app"
          "/Applications/IntelliJ IDEA CE.app"
          "/Applications/Obsidian.app"
          "/Applications/WezTerm.app"
          "/System/Applications/Utilities/Activity Monitor.app"
          "/System/Applications/System Settings.app"
        ];
      };

      # --- DONT TOUCH ---
      services.nix-daemon.enable = true;
      nix.settings.experimental-features = "nix-command flakes";
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;
      # ------------------

      # IF NOT ARM, CHANGE aarch64
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    darwinConfigurations."${flake_device}" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = user;
            autoMigrate = true;
          };
        }
      ];
    };

    darwinPackages = self.darwinConfigurations."${flake_device}".pkgs;
  };
}
