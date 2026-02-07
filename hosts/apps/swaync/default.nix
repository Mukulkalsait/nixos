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
      # General control center settings (defaults, adjust as needed)
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 0;
      control-center-width = 400;
      control-center-height = 600;
      fit-to-screen = true;
      hide-on-clear = true;
      hide-on-action = true;

      # Notification settings (defaults)
      notification-icon-size = 64;
      notification-body-image-height = 100;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      notification-window-width = 300;

      # Widgets to display in control center (add/remove as needed)
      widgets = [
        "title"
        "dnd"
        "mpris" # Music player if you want it
        "buttons-grid" # For toggles like bluetooth
        "menubar" # For dropdown menus (now with content)
        "notifications"
      ];

      # Configure specific widgets
      widget-config = {
        title = {
          text = "Control Center";
          clear-all-button = true;
          button-text = "Clear All";
        };

        dnd = {
          text = "Do Not Disturb";
        };

        buttons-grid = {
          actions = [
            # Bluetooth toggle (fixed with proper commands)
            {
              label = "Bluetooth";
              type = "toggle";
              active = false; # Default off; update-command will check real state
              command = "bluetoothctl power $( [ \"$SWAYNC_TOGGLE_STATE\" = true ] && echo on || echo off )";
              update-command = "bluetoothctl show | grep -q 'Powered: yes' && echo true || echo false";
            }

            # Example wifi toggle (assuming NetworkManager; add if you have it)
            {
              label = "WiFi";
              type = "toggle";
              active = false;
              command = "nmcli radio wifi $( [ \"$SWAYNC_TOGGLE_STATE\" = true ] && echo on || echo off )";
              update-command = "sh -c '[ \"$(nmcli radio wifi)\" = \"enabled\" ] && echo true || echo false'";
            }

            # Other example toggles (e.g., airplane mode via rfkill)
            {
              label = "Airplane Mode";
              type = "toggle";
              active = false;
              command = "rfkill $( [ \"$SWAYNC_TOGGLE_STATE\" = true ] && echo block || echo unblock ) all";
              update-command = "rfkill list | grep -q 'Soft blocked: yes' && echo true || echo false";
            }
          ];
        };

        menubar = {
          # Position buttons on the left or right
          position = "left";

          # Add a basic menu (not empty anymore)
          "menu#system" = {
            label = "System";
            position = "left";
            actions = [
              # Removed reboot and poweroff; added suspend as "something else"
              {
                label = "Suspend";
                command = "systemctl suspend";
              }
              # Example: Add a logout button if you want
              {
                label = "Logout";
                command = "loginctl terminate-user $USER";
              }
              # Add more custom actions here, e.g., a script
              {
                label = "Custom Script";
                command = "echo 'Hello' > ~/test.txt"; # Replace with your command
              }
            ];
          };

          # Optional: Direct buttons in the bar (no dropdown)
          buttons = {
            position = "right";
            actions = [
              # Example direct button
              {
                label = "Settings";
                command = "gnome-control-center"; # Or your preferred settings app
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
