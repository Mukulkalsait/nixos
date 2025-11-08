# Y : systemwide Costome Scripts which run with single cmd
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "vihaanDEstart" ''
      echo "🚀 Starting dev stack for VihaanAI Technologies ..."
      if sudo systemctl start nginx php-fpm mysql; then
        echo "✅ All services started successfully."
      else
        echo "❌ Something went wrong. Run vihaanDEstatus for systemctl status"
      fi
    '')

    (writeShellScriptBin "vihaanDEstatus" ''
      echo "📊 Printing dev stack status for VihaanAI Technologies ..."
      echo "=================================================================================== NGINX ==================================================================================="
      sudo systemctl status nginx --no-pager
      echo "=================================================================================== PHP-FPM ==================================================================================="
      sudo systemctl status php-fpm --no-pager
      echo "=================================================================================== MySQL ==================================================================================="
      sudo systemctl status mysql --no-pager
      echo "✅ All service statuses printed."
    '')

    (writeShellScriptBin "vihaanDEstop" ''
      echo "🛑 Stopping dev stack for VihaanAI Technologies ..."
      if sudo systemctl stop nginx php-fpm mysql; then
        echo "✅ All services stopped successfully."
      else
        echo "❌ Something went wrong. Run vihaanDEstatus for systemctl status"
      fi
    '')
  ];
}

