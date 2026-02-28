{ lib, config, pkgs, osConfig, ... }:

let
  terminal = "kitty";
in {
  home = {
    stateVersion = "25.11";
    username = "seiversiana";
    homeDirectory = "/home/seiversiana";
    packages = with pkgs; [
      # fonts
      iosevka
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      # downloads
      qbittorrent
      nicotine-plus
      # audio
      ffmpeg_7-full
      flacon
      sacd
      kid3-qt
      rsgain
      ardour
      lsp-plugins
      qpwgraph
      # coding
      typst
      tinymist
      rustup
      # visuals
      inkscape
      vlc
      # passwords
      gopass
      gopass-hibp
      # others
      xev
      btop
      flameshot
      file-roller
      ungoogled-chromium
      ltspice
    ];

    file = {
      ".fehbg".source = ./dotfiles/.fehbg;
      ".xinitrc".source = ./dotfiles/.xinitrc;
      "bg.png".source = ./dotfiles/bg.png;
    };
  };

  fonts.fontconfig.enable = true;

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      fonts = {
        names = [ "Iosevka Extended" ];
        style = "Regular";
        size = 10.0;
      };
      inherit terminal;
      modifier = "Mod4";
      keybindings = let
        modifier = config.xsession.windowManager.i3.config.modifier;
      in {
        "XF86AudioRaiseVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_SINK@ 5%+ --limit 1";
        "XF86AudioLowerVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_SINK@ 5%- --limit 0";
        "XF86AudioMute" = "exec --no-startup-id wpctl set-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec --no-startup-id wpctl set-mute @DEFAULT_SOURCE@ toggle";
        "XF86MonBrightnessUp" = "exec brightnessctl set 2%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 2%-";
        "Print" = "exec flameshot gui";
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+Shift+d" = "exec rofi -show drun";
        "${modifier}+p" = "exec \"gopass ls --flat | rofi -dmenu | xargs --no-run-if-empty gopass show -c\"";
        "${modifier}+j" = "focus left";
        "${modifier}+k" = "focus down";
        "${modifier}+l" = "focus up";
        "${modifier}+semicolon" = "focus right";
        "${modifier}+Shift+j" = "move left";
        "${modifier}+Shift+k" = "move down";
        "${modifier}+Shift+l" = "move up";
        "${modifier}+h" = "split h";
        "${modifier}+v" = "split v";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+Shift+semicolon" = "move right";
        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";
        "${modifier}+a" = "focus parent";
        "${modifier}+d" = "focus child";
        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";
        "${modifier}+Shift+e" = "exec i3-msg exit";
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";
      };
    };
  };

  programs.rofi = {
    enable = true;
    inherit terminal;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Nile Jocson";
      user.email = "seiversiana@gmail.com";
      user.signingkey = "87DD01B331F5544C";
      init.defaultBranch = "main";
      commit.gpgSign = true;
      tag.gpgSign = true;
    };
  };

  programs.gh.enable = true;

  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      settings = {
        "browser.shell.checkDefaultBrowser" = false;
        "signon.rememberSignons" = false;
        "extensions.InstallTrigger.enabled" = false;
        "extensions.autoDisableScopes" = 0;
      };
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        darkreader
        return-youtube-dislikes
      ];
    };
  };

  programs.kitty = {
    enable = true;
    font.name = "Iosevka Extended";
    font.size = 10;
  };

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        streetsidesoftware.code-spell-checker
        johnpapa.winteriscoming
        ms-vscode.cpptools
        llvm-vs-code-extensions.vscode-clangd
        ms-vscode.cmake-tools
        twxs.cmake
        eamodio.gitlens
        myriad-dreamin.tinymist
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
      ];
      userSettings = {
        "workbench.colorTheme" = "Winter is Coming (Dark Blue)";
        "editor.fontLigatures" = true;
        "editor.fontFamily" = "Iosevka Extended";
        "workbench.tree.indent" = 20;
        "files.trimTrailingWhitespace" = true;
        "editor.renderWhitespace" = "all";
        "files.insertFinalNewline" = true;
        "files.trimFinalNewlines" = true;
        "editor.insertSpaces" = false;
        "C_Cpp.intelliSenseEngine" = "disabled";
        "chat.disableAIFeatures" = true;
        "[typst]"."editor.tabSize" = 4;
      };
    };
  };

  services.easyeffects = {
    enable = true;
    extraPresets = {
      default = {
        output = {
          blocklist = [];
          "plugins_order" = [
            "equalizer#0"
          ];
          "equalizer#0" = {
            "balance" = 22.5;
          };
        };
      };
    };
    preset = "default";
  };

  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    extraConfig = ''
      replaygain "auto"
      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }
    '';
  };

  services.mpdscribble = {
    enable = true;
    endpoints = {
      "listenbrainz" = {
        username = "seiversiana";
        passwordFile = "${config.home.homeDirectory}/listenbrainz_password";
      };
    };
  };

  programs.rmpc.enable = true;

  programs.feh.enable = true;

  xdg.mime.enable = true;
  xdg.mimeApps.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
