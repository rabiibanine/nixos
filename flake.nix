{
  descrption = "My NixOS flakes configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager } @ inputs:
    let
      
      system = "x86_64-linux";

    in

    {
      nixosConfigurations.pizzahub = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
	modules = [
	  ./configuration.nix
	];
      };
    };
}
