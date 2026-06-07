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

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, noctalia, antigravity-nix, spicetify-nix, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix
        
        spicetify-nix.nixosModules.default

        ({ pkgs, ... }: 
        let
          spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
        in
        {
          environment.systemPackages = [
            antigravity-nix.packages.x86_64-linux.default
            antigravity-nix.packages.x86_64-linux.google-antigravity-ide
            antigravity-nix.packages.x86_64-linux.google-antigravity-cli
          ];

          programs.spicetify = {
            enable = true;
            enabledExtensions = with spicePkgs.extensions; [
              hidePodcasts
              shuffle
            ];
            theme = spicePkgs.themes.hazy;
            #colorScheme = "Base";
          };
        })
      ];
    };
  };
}
