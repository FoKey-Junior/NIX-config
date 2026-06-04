{
  description = "My NixOS Flake with Noctalia";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11"; 

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, noctalia, antigravity-nix,... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };

      modules = [
      	./configuration.nix 
        
	{
          environment.systemPackages = [
            antigravity-nix.packages.x86_64-linux.default
            antigravity-nix.packages.x86_64-linux.google-antigravity-ide
            antigravity-nix.packages.x86_64-linux.google-antigravity-cli
          ];
        }
      ];
    };
  };
}
