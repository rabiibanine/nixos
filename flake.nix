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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";

      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
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
        home-manager.nixosModules.home-manager
        nixvim.nixosModules.nixvim
        nixpkgs.nixosModules.readOnlyPkgs
        {
          nixpkgs.pkgs = pkgs;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.pizzakat = import ./home.nix;
          home-manager.extraSpecialArgs = { inherit inputs pkgs; };
        }
      ];
    in
    {
      nixosConfigurations."pizzahub" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = sharedModules ++ [
          ./laptop-hardware.nix
          { networking.hostName = "pizzahub"; }
        ];
      };

      nixosConfigurations."pizzahub-vm" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = sharedModules ++ [
          ./vm-hardware.nix
          { networking.hostName = "pizzahub-vm"; }
        ];
      };
    };
}
