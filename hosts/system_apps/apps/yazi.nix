

{ config, pkgs ,yazi, ... }:
{
nixosConfigurations = {
			nixos = nixpkgs.lib.nixosSystem {
				modules = [
					({ pkgs, ... }: {
						environment.systemPackages = [
							(yazi.packages.${pkgs.system}.default.override {
								_7zz = pkgs._7zz-rar;  # Support for RAR extraction
							})
						];
					})
				];
			};
		};
}















