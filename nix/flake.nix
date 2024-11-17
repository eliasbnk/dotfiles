/*
    !CHECKME: 
    NIX DOCS: https://mynixos.com/options
    HOMEBREW DOCS: https://docs.brew.sh/Manpage
    MACOS SETTINGS DOCS: https://macos-defaults.com
 */

{
  description = "Nix-Darwin Flake";

  inputs = {
    # !-----------↓↓ DO NOT EDIT ↓↓----------!
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    # !-----------↑↑ DO NOT EDIT ↑↑----------!
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {
      
      # -------- Homebrew Configuration --------
      homebrew = {
        # !-----------↓↓ DO NOT EDIT ↓↓----------!
        enable = true;  # Enable Homebrew package manager
        # !-----------↑↑ DO NOT EDIT ↑↑----------!

        brews = [
          # TODO: Add the Homebrew formulae (packages) you want to install
          "neovim"                    # Better vim editor
          "openjdk"                   # Java development tools
          "git-delta"                 # Better git diff
          "zoxide"                    # Better 'cd'
          "openssl"                   # SSL libraries
          "cmake"                     # build C++ code
          "tldr"                      # Better man pages
          "speedtest-cli"             # Internet speed test
          "fd"                        # Improved 'find'
          "git"                       # Git CLI tool
          "yarn"                      # JavaScript package manager
          "nvm"                       # Manage NodeJS versions
          "zsh"                       # Z shell
          "bat"                       # Better 'cat'
          "imagemagick"               # Image manipulation tool
          "python3"                   # Python
          "sshpass"                   # SSH password manager
          "fzf"                       # Fuzzy finder
          "eza"                       # Better 'ls'
          "spaceship"                 # Terminal theme (alternatively: 'starship')
          "zsh-autocomplete"          # Autocompletion for terminal
          "zsh-syntax-highlighting"   # Syntax highlighting for terminal
          "zsh-autosuggestions"       # Autosuggestions for terminal
        ];

        casks = [
          # TODO: Add the macOS applications (Casks) you want to install
          "librewolf"                  # Better Firefox (alternative: brave-browser)
          "viber"                      # Messaging app
          "1password"                  # Password manager
          "aldente"                    # (!PAID!) Battery saver (free alternative: battery)
          "forklift"                   # (!PAID!) Finder replacement + SFTP client ( free SFTP client: cyberduck )
          "redquits"                   # Quit apps with 'x'
          "quit-all"                   # Quit a lot of apps quickly
          "devutils"                   # (!PAID!) Developer utilities
          "maccy"                      # Clipboard manager
          "muzzle"                     # Silence notifications during screen share
          "raycast"                    # Spotlight replacement with better search
          "stats"                      # System stats in the menu bar
          "clop"                       # File compression tool
          "onyx"                       # Disk maintenance tool
          "disk-drill"                 # Data recovery tool
          "lulu"                       # Firewall
          "protonvpn"                  # VPN client
          "middleclick"                # emulate a scroll wheel click 
          "readdle-spark"              # Email client
          "bartender"                  # Hide apps in menu bar
          "cleanshot"                  # (!PAID!) Screenshot tool (free alternative: shottr)
          "alt-tab"                    # Command-tab alternative
          "iina"                       # Video player
          "keka"                       # Archive tool
          "imageoptim"                 # Image optimization
          "topnotch"                   # Hide menu bar notch
          "betterdisplay"              # External monitor control
          "keepingyouawake"            # Prevent the system from going into sleep
          "nikitabobko/tap/aerospace"  # Window management tool (i3wm + "PopOS"-ness)
          "postman"                    # API testing tool
          "slack"                      # Messaging platform
          "zoom"                       # Video conferencing tool
          "discord"                    # Communication tool
          "obsidian"                   # Note-taking app
          "spotify"                    # Music streaming
          "wezterm"                    # Terminal emulator
          "visual-studio-code"         # Code editor
          "clion"                      # C++ IDE
          "pycharm-ce"                 # Python IDE
          "intellij-idea-ce"           # Java IDE
          "font-fira-code"            # Programming font  
          "font-hack-nerd-font"       # Programming font & ICONS
        ];

        caskArgs.no_quarantine = true;

        # Homebrew post-activation settings
        onActivation.cleanup = "zap";     # Clean up after activation
        onActivation.autoUpdate = true;   # Enable auto-update
        onActivation.upgrade = true;      # Enable auto-upgrade
      };

      services.nix-daemon.enable = true;
      # Enable experimental Nix features
      nix.settings.experimental-features = "nix-command flakes";

      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;

      nixpkgs.hostPlatform = "aarch64-darwin";    # FIXME: Change to x86_64-darwin for Intel Macs

      

      # -------- macOS Default Settings --------
      system.defaults = {

        # READ: https://mynixos.com/options/system.defaults.dock
        dock.mineffect = "scale";             # App minimize effect
        dock.autohide = true;                 # Auto-hide the Dock
        dock.autohide-delay = 0.0;            # Dock auto-hide delay (0.0 = instant)
        dock.autohide-time-modifier = 0.0;    # Speed of Dock hide/show animation
        dock.minimize-to-application = true;  # Minimize to app icon
        dock.mru-spaces = false;              # Rearrange Spaces based on most recent use
        dock.orientation = "left";            # Dock location on the screen
        dock.show-recents = false;            # Show recent apps in dock
        dock.showhidden = true;               # Show hidden app icons as translucent
        dock.persistent-apps = [
          # TODO: Add the paths of applications you want to keep in the Dock
          # order: top to bottom / left to right
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
          "/System/Applications/System Settings.app"

        ];

        # READ: https://mynixos.com/options/system.defaults.NSGlobalDomain
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

        # READ: https://mynixos.com/options/system.defaults.menuExtraClock
        menuExtraClock.ShowSeconds = true;
        menuExtraClock.ShowDayOfWeek = true;
        menuExtraClock.ShowDate = 1;
        menuExtraClock.ShowAMPM = false;
        menuExtraClock.Show24Hour = true;

        # READ: https://mynixos.com/options/system.defaults.finder
        finder.FXDefaultSearchScope = "SCcf";
        finder.FXPreferredViewStyle = "Nlsv";
        finder.ShowPathbar = true;
        finder.ShowStatusBar = true;

        # READ: https://mynixos.com/options/system.defaults.screencapture
        screencapture.type = "jpg";
        screencapture.location = "~/Screenshots";
        screencapture.disable-shadow = true;
        screencapture.include-date = false;

        # READ: https://mynixos.com/options/system.defaults.screensaver
        screensaver.askForPasswordDelay = 1;
        screensaver.askForPassword = true;

        # READ: https://mynixos.com/nix-darwin/option/system.defaults.WindowManager.EnableStandardClickToShowDesktop
        WindowManager.EnableStandardClickToShowDesktop = false;

        # READ: https://mynixos.com/nix-darwin/option/system.defaults.loginwindow.GuestEnabled
        loginwindow.GuestEnabled = false;

        # READ: https://daiderd.com/nix-darwin/manual/index.html#opt-system.defaults.hitoolbox.AppleFnUsageType
        hitoolbox.AppleFnUsageType = "Show Emoji & Symbols";

        # READ: https://daiderd.com/nix-darwin/manual/index.html#opt-system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates
        SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;    
      };

      # -------- System Configuration --------
      security.pam.enableSudoTouchIdAuth = true;  # Enable Touch ID for sudo authentication
      system.startup.chime = false;               # Enable startup chime
    };
  in
  {
    # -------- Darwin Configuration --------
    # FIXME: OTIONALLY CHANGE DEVICE NAME: "macbook-pro"
    # make sure the the device name mathes up with:
    # - - darwinPackages = self.darwinConfigurations."macbook-pro".pkgs - -
    darwinConfigurations."macbook-pro" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # !-----------↓↓ DO NOT EDIT ↓↓----------!
            enable = true;
            # !-----------↑↑ DO NOT EDIT ↑↑----------!
            enableRosetta = true;  # Enable Rosetta 2 for Apple Silicon
            user = "babenkoilya";  # FIXME: Change this to your macOS username (use `whoami`)
           
            autoMigrate = true; 

          };
        }
      ];
    };

    # Darwin packages available for the configured system
    # FIXME: OTIONALLY CHANGE DEVICE NAME: "macbook-pro"
    # make sure the the device name mathes up with:
    # - - darwinConfigurations."macbook-pro" = nix-darwin.lib.darwinSystem - -
    darwinPackages = self.darwinConfigurations."macbook-pro".pkgs;
  };
}
