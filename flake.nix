{ 
	description = "System flake";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager/release-23.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		ags.url = "github:Aylur/ags";
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs: 
	let 
		lib = nixpkgs.lib;
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {
		nixosConfigurations = {
			nixos = lib.nixosSystem {
				inherit system;
				modules = [ ./configuration.nix ];
			};
		};
		homeConfigurations = {
			dave = home-manager.lib.homeManagerConfiguration {
				# inherit pkgs;
				pkgs = import nixpkgs { inherit system; };
				extraSpecialArgs = { inherit inputs; };
				modules = [ 
					./home.nix 
				];
			};
		};
	};
}
