{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, antigravity-nix, ... }: {
    nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
          environment.systemPackages = [
            antigravity-nix.packages.x86_64-linux.default # Base App
            antigravity-nix.packages.x86_64-linux.google-antigravity-ide # IDE
            antigravity-nix.packages.x86_64-linux.google-antigravity-cli # CLI
          ];
        }
      ];
    };
  };
}
