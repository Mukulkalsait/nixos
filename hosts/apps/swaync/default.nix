# Y: Notifications Center Customisation.
{

  home.file.".config/swaync/scripts/".source = ./scripts;

  # Y:  add into hyrpland config => exec-once = while true; do ~/.config/swaync/scripts/battery-warning.sh; sleep 60; done &
  # havnt added till now.
  #
  #             ~/.config/swaync/scripts/battery-warning.sh
  # /home/mukuldk/.config/swaync/scripts/battery-warning.sh

  services.swaync = {
    enable = true;
    settings = {
      # Position and appearance
      positionX = "right";
      positionY = "top";
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 10;
      control-center-width = 500;
      control-center-height = 600;
      control-center-radius = 12;

      # Layer settings
      fit-to-screen = true;
      layer-shell = true;
      layer = "overlay";
      control-center-layer = "overlay";
      cssPriority = "user";

      # Notification settings
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      notification-window-width = 400;

      # Timeouts
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;

      # Behavior
      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = true;
      notification-inline-replies = false;
      notification-2fa-action = true;

      # Image visibility
      image-visibility = "when-available";
      transition-time = 200;

      # Keyboard shortcuts
      keyboard-shortcuts = true;

      # Widget order - MORE WIDGETS!
      widgets = [
        "inhibitors"
        "title"
        "dnd"
        "mpris"
        "volume"
        "backlight"
        "buttons-grid"
        "menubar"
        "notifications"
      ];

      # Widget configurations
      widget-config = {
        # Title widget
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = " Clear All";
        };

        # Do Not Disturb
        dnd = {
          text = "Do Not Disturb";
        };

        # Inhibitors (prevents sleep/screen off)
        inhibitors = {
          text = "Inhibitors";
          button-text = "Clear All";
          clear-all-button = true;
        };

        # Media player controls
        mpris = {
          image-size = 96;
          image-radius = 8;
          blur = true;
        };

        # Volume control
        volume = {
          label = "󰕾";
          show-per-app = true;
        };

        # Brightness control
        backlight = {
          label = "󰃠";
          device = "intel_backlight";
          subsystem = "backlight";
        };

        # Buttons grid - quick actions
        buttons-grid = {
          actions = [
            {
              label = "󰐥";
              command = "systemctl poweroff";
            }
            {
              label = "󰜉";
              command = "systemctl reboot";
            }
            {
              label = "󰤄";
              command = "nmcli radio wifi toggle";
            }
            {
              label = "󰂯";
              command = "bluetoothctl power toggle";
            }
          ];
        };

        # Menu bar - custom scripts
        menubar = {
          menu.power-profiles = {
            label = "󰈐";
            position = "right";
            actions = [
              {
                label = " Performance";
                command = "echo performance | sudo tee /sys/firmware/acpi/platform_profile";
              }
              {
                label = " Balanced";
                command = "echo balanced | sudo tee /sys/firmware/acpi/platform_profile";
              }
              {
                label = " Low Power";
                command = "echo low-power | sudo tee /sys/firmware/acpi/platform_profile";
              }
            ];
          };
          menu.screenshots = {
            label = "󰹑";
            position = "right";
            actions = [
              {
                label = " Screen";
                command = "grimblast copy screen";
              }
              {
                label = " Area";
                command = "grimblast copy area";
              }
              {
                label = " Window";
                command = "grimblast copy active";
              }
            ];
          };
        };
      };

      # Scripts for battery warnings
      scripts = {
        battery-warning = {
          exec = "~/.config/swaync/scripts/battery-warning.sh";
          urgency = "Critical";
        };
      };

      # Notification visibility rules
      notification-visibility = {
        battery = {
          state = "enabled";
          urgency = "Critical";
          app-name = "battery";
        };
        upower = {
          state = "enabled";
          urgency = "Critical";
        };
      };
    };

    # Custom CSS styling
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14px;
      }

      .notification-row {
        outline: none;
        margin: 0px;
        padding: 0px;
      }

      .notification {
        background: rgba(30, 30, 46, 0.9);
        border-radius: 12px;
        margin: 8px;
        padding: 0;
        border: 2px solid rgba(137, 180, 250, 0.5);
      }

      .notification.critical {
        border: 2px solid rgba(243, 139, 168, 1);
      }

      .notification-content {
        background: transparent;
        padding: 8px;
        border-radius: 12px;
      }

      .notification-default-action {
        background: transparent;
      }

      .close-button {
        background: rgba(243, 139, 168, 0.5);
        color: #1e1e2e;
        border-radius: 8px;
        margin: 8px;
        padding: 4px;
      }

      .close-button:hover {
        background: rgba(243, 139, 168, 1);
      }

      .control-center {
        background: rgba(30, 30, 46, 0.95);
        border-radius: 12px;
        border: 2px solid rgba(137, 180, 250, 0.5);
      }

      .control-center-list {
        background: transparent;
      }

      .widget-title {
        background: rgba(137, 180, 250, 0.2);
        color: #cdd6f4;
        border-radius: 8px;
        padding: 8px;
        margin: 8px;
        font-size: 16px;
        font-weight: bold;
      }

      .widget-title > button {
        background: rgba(243, 139, 168, 0.5);
        color: #1e1e2e;
        border-radius: 8px;
        padding: 4px 12px;
      }

      .widget-title > button:hover {
        background: rgba(243, 139, 168, 1);
      }

      .widget-dnd {
        background: rgba(137, 180, 250, 0.1);
        border-radius: 8px;
        margin: 8px;
        padding: 8px;
      }

      .widget-dnd > switch {
        background: rgba(88, 91, 112, 0.5);
        border-radius: 16px;
      }

      .widget-dnd > switch:checked {
        background: rgba(137, 180, 250, 1);
      }

      .widget-mpris {
        background: rgba(137, 180, 250, 0.1);
        border-radius: 8px;
        margin: 8px;
        padding: 12px;
      }

      .widget-mpris-player {
        background: transparent;
      }

      .widget-mpris > button {
        background: rgba(137, 180, 250, 0.3);
        border-radius: 8px;
        color: #cdd6f4;
      }

      .widget-mpris > button:hover {
        background: rgba(137, 180, 250, 0.5);
      }

      .widget-volume {
        background: rgba(166, 227, 161, 0.1);
        border-radius: 8px;
        margin: 8px;
        padding: 8px;
      }

      .widget-backlight {
        background: rgba(249, 226, 175, 0.1);
        border-radius: 8px;
        margin: 8px;
        padding: 8px;
      }

      .widget-buttons-grid {
        background: rgba(137, 180, 250, 0.1);
        border-radius: 8px;
        margin: 8px;
        padding: 8px;
      }

      .widget-buttons-grid > flowbox > flowboxchild > button {
        background: rgba(137, 180, 250, 0.2);
        border-radius: 8px;
        margin: 4px;
        padding: 12px;
        font-size: 24px;
      }

      .widget-buttons-grid > flowbox > flowboxchild > button:hover {
        background: rgba(137, 180, 250, 0.4);
      }

      .widget-menubar {
        background: rgba(137, 180, 250, 0.1);
        border-radius: 8px;
        margin: 8px;
        padding: 8px;
      }

      .widget-menubar > box > button {
        background: rgba(137, 180, 250, 0.2);
        border-radius: 8px;
        margin: 4px;
        padding: 8px;
        font-size: 20px;
      }

      .widget-menubar > box > button:hover {
        background: rgba(137, 180, 250, 0.4);
      }
    '';
  };
}
