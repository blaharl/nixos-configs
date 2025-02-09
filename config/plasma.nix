{ config, pkgs, ... }:

let
  userAliases = {
    showplasma="python3 ~/.dotfiles/files/plasma-manager/script/rc2nix.py";
    openhome="sudo nft -f ~/.dotfiles/scripts/excludeTraffic.rules; sleep 1; mullvad connect; sleep 1; mullvad reconnect; mv ~/.config/powerdevilrc.tmp ~/.config/powerdevilrc";
  };
in 

{
  imports = [
    #../plasma-manager/modules
    #<plasma-manager/modules>
  ];

  home = {
    packages = [
    ];
    file = {
      ".config/autostart/startup.sh.desktop".source = ./file/plasma/startup.sh_config.desktop;
      ".config/powerdevilrc.tmp".source = ./file/plasma/powerdevilrc_config.tmp;
      ".local/share/user-places.xbel".source = ./file/plasma/user-places_local_share.xbel;
      ".config/mimeapps.list".source = ./file/plasma/mimeapps_config.list;
    };
    sessionVariables = {
    };
  };

  programs.plasma = {
    enable = true;

    #
    # Some high-level settings:
    #
    workspace = {
      # clickItemTo = "open"; # If you liked the click-to-open default from plasma 5
      clickItemTo = "select";
      lookAndFeel = "org.kde.breezedark.desktop";
      cursor = {
        theme = "Bibata-Modern-Ice";
        # size = 32;
      };
      colorScheme = "BreezeDark";
      iconTheme = "breeze-dark";
      # wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Patak/contents/images/1080x1920.png";
    };

    hotkeys.commands = {
      "launch-konsole" = {
        name = "Launch Konsole";
        key = "Alt+Shift+T";
        command = "konsole";
      };
      "launch-wofi" = {
        name = "Launch wofi";
        key = "Alt+Shift+Z";
        command = "wofi -I -i --show drun";
      };
    };

    panels = [
      # Windows-like panel at the bottom
      {
        location = "bottom";
        widgets = [
          # We can configure the widgets by adding the name and config
          # attributes. For example to add the the kickoff widget and set the
          # icon to "nix-snowflake-white" use the below configuration. This will
          # add the "icon" key to the "General" group for the widget in
          # ~/.config/plasma-org.kde.plasma.desktop-appletsrc.
          {
            name = "org.kde.plasma.kickoff";
            config = {
              General = {
                icon = "nix-snowflake-white";
                alphaSort = true;
              };
            };
          }
          {
            name = "org.kde.plasma.pager";
          }
          # Or you can configure the widgets by adding the widget-specific options for it.
          # See modules/widgets for supported widgets and options for these widgets.
          # For example:
          #{
          #  kickoff = {
          #    sortAlphabetically = true;
          #    icon = "nix-snowflake-white";
          #  };
          #}
          # Adding configuration to the widgets can also for example be used to
          # pin apps to the task-manager, which this example illustrates by
          # pinning dolphin and konsole to the task-manager by default with widget-specific options.
          {
            iconTasks = {
              launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:systemsettings.desktop"
                "applications:org.kde.konsole.desktop"
              ];
            };
          }
          # Or you can do it manually, for example:
          #{
          #  name = "org.kde.plasma.icontasks";
          #  config = {
          #    General = {
          #      launchers = [
          #        "applications:org.kde.dolphin.desktop"
          #        "applications:org.kde.konsole.desktop"
          #      ];
          #    };
          #  };
          #}
          # If no configuration is needed, specifying only the name of the
          # widget will add them with the default configuration.
          "org.kde.plasma.marginsseparator"
          # If you need configuration for your widget, instead of specifying the
          # the keys and values directly using the config attribute as shown
          # above, plasma-manager also provides some higher-level interfaces for
          # configuring the widgets. See modules/widgets for supported widgets
          # and options for these widgets. The widgets below shows two examples
          # of usage, one where we add a digital clock, setting 12h time and
          # first day of the week to Sunday and another adding a systray with
          # some modifications in which entries to show.
          {
            systemTray.items = {
              # We explicitly show bluetooth and battery
              shown = [
                "org.kde.plasma.bluetooth"
              ];
              # And explicitly hide networkmanagement and volume
              hidden = [
                "org.kde.plasma.battery"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.volume"
              ];
            };
          }
          {
            digitalClock = {
              calendar.firstDayOfWeek = "sunday";
              time.format = "12h";
            };
          }
        ];
        hiding = "autohide";
      }
      # Application name, Global menu and Song information and playback controls at the top
      #{
      #  location = "top";
      #  height = 26;
      #  widgets = [
      #    {
      #      applicationTitleBar = {
      #        behavior = {
      #          activeTaskSource = "activeTask";
      #        };
      #        layout = {
      #          elements = [ "windowTitle" ];
      #          horizontalAlignment = "left";
      #          showDisabledElements = "deactivated";
      #          verticalAlignment = "center";
      #        };
      #        overrideForMaximized.enable = false;
      #        titleReplacements = [
      #          {
      #            type = "regexp";
      #            originalTitle = "^Brave Web Browser$";
      #            newTitle = "Brave";
      #          }
      #          {
      #            type = "regexp";
      #            originalTitle = ''\\bDolphin\\b'';
      #            newTitle = "File manager";
      #          }
      #        ];
      #        windowTitle = {
      #          font = {
      #            bold = false;
      #            fit = "fixedSize";
      #            size = 12;
      #          };
      #          hideEmptyTitle = true;
      #          margins = {
      #            bottom = 0;
      #            left = 10;
      #            right = 5;
      #            top = 0;
      #          };
      #          source = "appName";
      #        };
      #      };
      #    }
      #    "org.kde.plasma.appmenu"
      #    "org.kde.plasma.panelspacer"
      #    {
      #      plasmusicToolbar = {
      #        panelIcon = {
      #          albumCover = {
      #            useAsIcon = false;
      #            radius = 8;
      #          };
      #          icon = "view-media-track";
      #        };
      #        preferredSource = "spotify";
      #        musicControls.showPlaybackControls = true;
      #        songText = {
      #          displayInSeparateLines = true;
      #          maximumWidth = 640;
      #          scrolling = {
      #            behavior = "alwaysScroll";
      #            speed = 3;
      #          };
      #        };
      #      };
      #    }
      #  ];
      #}
    ];

   # window-rules = [
   #   {
   #     description = "Dolphin";
   #     match = {
   #       window-class = {
   #         value = "dolphin";
   #         type = "substring";
   #       };
   #       window-types = [ "normal" ];
   #     };
   #     apply = {
   #       noborder = {
   #         value = true;
   #         apply = "force";
   #       };
   #       # `apply` defaults to "apply-initially"
   #       # maximizehoriz = true;
   #       # maximizevert = true;
   #     };
   #   }
   # ];

    powerdevil = {
      AC = {
        powerButtonAction = "lockScreen";
        autoSuspend = {
          action = "sleep";
          idleTimeout = 1200;
        };
        turnOffDisplay = {
          idleTimeout = 600;
          idleTimeoutWhenLocked = "immediately";
        };
      };
      battery = {
        powerButtonAction = "sleep";
        whenSleepingEnter = "standbyThenHibernate";
      };
      lowBattery = {
        whenLaptopLidClosed = "sleep";
      };
    };

    kwin = {
      edgeBarrier = 0; # Disables the edge-barriers introduced in plasma 6.1
      cornerBarrier = false;

      # scripts.polonium.enable = true;
    };

    kscreenlocker = {
      lockOnResume = true;
      timeout = 10;
    };

    #
    # Some mid-level settings:
    #
    shortcuts = {
      ksmserver = {
        "Lock Session" = [ "Alt+Shift+L" "Meta+Ctrl+Alt+L,Meta+L" "Screensaver,Lock Session" ];
      };

      kwin = {
        "Expose" = "Meta+,";
        "Switch Window Down" = "Meta+J";
        "Switch Window Left" = "Meta+H";
        "Switch Window Right" = "Meta+L";
        "Switch Window Up" = "Meta+K";
        "Toggle Night Color" = "Alt+Shift+N";
      };
    };

    spectacle.shortcuts = {
      recordRegion = "Alt+Shift+R";
      recordScreen = "Alt+Shift+W";
      recordWindow = "Alt+Shift+E";
      captureEntireDesktop = "Alt+!";
      captureCurrentMonitor = "Alt+@";
      captureActiveWindow = "Alt+#";
      captureRectangularRegion = "Alt+$";
    };

    #
    # Some low-level settings:
    #
    configFile = {
      baloofilerc."Basic Settings"."Indexing-Enabled" = false;
      kwinrc."org.kde.kdecoration2" = {
        ButtonsOnLeft = "SF";
        NoPlugin = "false";
        library = "org.kde.breeze";
        theme = "Breeze";
      };
      kwinrc."NightColor" = {
        Active = true;
        Mode = "Times";
      };
      kwinrc.Desktops = {
        Number = {
        value = 4;
        # Forces kde to not change this value (even through the settings app).
        immutable = true;
        };
        Rows.value = 1;
      };
      kwinrc."MouseBindings"."CommandAllWheel" = "Change Opacity";
      dolphinrc."General"."RememberOpenedTabs" = false;
      dolphinrc."PreviewSettings"."Plugins" = "appimagethumbnail,evince,audiothumbnail,blenderthumbnail,comicbookthumbnail,cursorthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,fontthumbnail,imagethumbnail,jpegthumbnail,mobithumbnail,opendocumentthumbnail,gsthumbnail,rawthumbnail,svgthumbnail,ffmpegthumbs";

      kdeglobals.KDE.widgetStyle = "Breeze";
      kdeglobals."KScreen"."XwaylandClientsScale" = false;
      # kdeglobals."General"."ColorScheme" = "BreezeDark";
      # kdeglobals."LookAndFeelPackage" = "org.kde.breezedark.desktop";
      kscreenlockerrc = {
        # Theme = "org.kde.breezedark.desktop";
        Greeter.Theme = "org.kde.breezedark.desktop";
        Greeter.WallpaperPlugin = "org.kde.potd";
        # To use nested groups use / as a separator. In the below example,
        # Provider will be added to [Greeter][Wallpaper][org.kde.potd][General].
        "Greeter/Wallpaper/org.kde.potd/General".Provider = "simonstalenhag";
      };
      ksplashrc = {
        KSplash.Engine = "KSplashQML";
        KSplash.Theme = "org.kde.breezedark.desktop";
      };
      # package = "org.kde.breezedark.desktop";
    };
  };


  dconf.settings = {
    "desktop/ibus/general" = {
      preload-engines = [ "hangul" ];
      version = "1.5.30";
    };
    "org/freedesktop/ibus/engine/hangul" = {
      auto-reorder = true;
      hangul-keyboard = "2";
      hanja-keys = "Hangul_Hanja";
      initial-input-mode = "latin";
      switch-keys = "Hangul";
      word-commit = false;
    };
  };

  programs.bash = {
    shellAliases = userAliases;
  };

  programs.fish = {
    shellAliases = userAliases;
  };

  programs.zsh = {
    shellAliases = userAliases;
  };
}
