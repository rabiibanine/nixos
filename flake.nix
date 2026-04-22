{

  description = "My NixOS flakes configuration";

  inputs = {

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixvim,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      sharedModules = [
	  ./configuration.nix
	  ./nixvim.nix
	  nixvim.nixosModules.nixvim
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.pizzakat = import ./home.nix;
	    home-manager.extraSpecialArgs = { inherit inputs pkgs; };
	  }
      ];
    in
    {
      nixosConfigurations."pizzahub" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs pkgs; };
	modules = sharedModules ++ [ 
	  ./laptop-hardware.nix
	  { networking.hostName = "pizzahub"; }
        ];
      };

      nixosConfigurations."pizzahub-vm" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs pkgs; };
	modules = sharedModules ++ [ 
	  ./vm-hardware.nix
	  { networking.hostName = "pizzahub-vm"; }
        ];
      };
    };
}
