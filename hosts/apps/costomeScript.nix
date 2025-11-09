# Y : systemwide Costome Scripts which run with single cmd
{ pkgs, ... }:
{
  # Y:  use "environment.systemPackages" for Root user scripts.
  home.packages = with pkgs; [

    (writeShellScriptBin "vihaanDEstart" ''
      echo "🚀 Starting dev stack for VihaanAI Technologies ..."

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
      start_service nginx
      start_service mysql
      echo "✨ Stack start attempt completed. Run 'vihaanDEstatus' to verify."
    '')
    (writeShellScriptBin "vihaanDErestart" ''
      echo "🔄 Restarting dev stack for VihaanAI Technologies ..."
      sudo systemctl restart nginx mysql
      echo "✅ All services restarted."
    '')


    (writeShellScriptBin "vihaanDEstatus" ''
      echo "📊 Printing dev stack status for VihaanAI Technologies ..."
      echo "=================================================================================== NGINX ==================================================================================="
      sudo systemctl status nginx --no-pager
      # echo "=================================================================================== PHP-FPM ==================================================================================="
      # sudo systemctl status php-fpm --no-pager
      echo "=================================================================================== MySQL ==================================================================================="
      sudo systemctl status mysql --no-pager
      echo "All service statuses printed."
    '')

    (writeShellScriptBin "vihaanDEstop" ''
      echo "🛑 Stopping dev stack for VihaanAI Technologies ..."
      if sudo systemctl stop nginx mysql; then
        echo "✅ All services stopped successfully."
      else
        echo "❌ Something went wrong. Run vihaanDEstatus for systemctl status"
      fi
    '')
  ];
}

