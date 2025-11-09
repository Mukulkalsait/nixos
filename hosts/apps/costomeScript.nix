# Y : systemwide Costome Scripts which run with single cmd

{ pkgs, ... }:
{
  # Y:  use "environment.systemPackages" for Root user scripts.
  home.packages = with pkgs; [
    (writeShellScriptBin "vde" ''
      #!/usr/bin/env bash

      # Vihaan Dev Environment Control Script
      SERVICES=("nginx" "mysql")

      print_help() {
        echo "⚙️vde [ Vihaan Dev Environment ]  
      ==================================================
      |             Usage: vde [cmd]                   |
      |------------------------------------------------|
      |  cmd      |            usages                  |
      |------------------------------------------------|
      |  h        |  Pring this help                   |
      |  s        |  Start all services                |
      |  st       |  Stop all services                 |
      |  r        |  Restart all services              |
      |  sta      |  Show status of all services       |
      |           |                                    |
      |           |                                    |
      |           |                                    |
      |___________|____________________________________|
      "
      }

      start_service() {
        local svc=$1
        if systemctl is-active --quiet "$svc"; then
          echo "⚡ $svc is already running."
        else
          echo "▶ Starting $svc ..."
          if sudo systemctl start "$svc"; then
            echo "✅ $svc started successfully."
          else
            echo "❌ Failed to start $svc."
          fi
        fi
      }

      stop_service() {
        local svc=$1
        if systemctl is-active --quiet "$svc"; then
          echo "⏹ Stopping $svc ..."
          if sudo systemctl stop "$svc"; then
            echo "✅ $svc stopped successfully."
          else
            echo "❌ Failed to stop $svc."
          fi
        else
          echo "⚡ $svc is not running."
        fi
      }

      case "$1" in
        s)
          echo "🚀 Starting Vihaan Dev Environment ..."
          for s in "''${SERVICES[@]}"; do
            start_service "$s"
          done
          echo "✨ All start operations complete."
          ;;
        st)
          echo "🛑 Stopping Vihaan Dev Environment ..."
          for s in "''${SERVICES[@]}"; do
            stop_service "$s"
          done
          echo "✨ All stop operations complete."
          ;;
        r)
          echo "🔄 Restarting Vihaan Dev Environment ..."
          sudo systemctl restart "''${SERVICES[@]}"
          echo "✅ All services restarted."
          ;;
        sta)
          echo "📊 Status for Vihaan Dev Environment:"
          for s in "''${SERVICES[@]}"; do
            echo "================================================================================== $s =================================================================================="
            sudo systemctl status "$s" --no-pager
          done
          echo "✅ All service statuses printed."
          ;;
        h|--help|"")
          print_help
          ;;
        *)
          echo "❌ Unknown command: $1"
          print_help
          ;;
      esac
    '')
  ];
}


