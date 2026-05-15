{
	description = "neviusiana-nixos flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nur = {
			url = "github:nix-community/NUR";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		aagl = {
			url = "github:ezKEa/aagl-gtk-on-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs@{ nixpkgs, home-manager, nur, aagl, ... }: {
		nixosConfigurations.neviusiana-nixos = nixpkgs.lib.nixosSystem {
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager = {
						backupFileExtension = "backup";
						useGlobalPkgs = true;
						useUserPackages = true;
						users.neviusiana = import ./neviusiana.nix;
					};
				}
				nur.modules.nixos.default
				{
					imports = [ aagl.nixosModules.default ];
					nix.settings = aagl.nixConfig;
					programs.anime-game-launcher.enable = true;
				}
			];
		};
	};
}
