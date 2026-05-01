{
  description = "My NixOS Flake with Noctalia";

  inputs = {
    # Укажите вашу текущую ветку (например, 25.11 или unstable)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11"; 
    
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs"; # Защита драйвера NVIDIA от конфликтов
    };
  };

  outputs = { self, nixpkgs, noctalia,... }@inputs: {
    # Имя "nixos" должно совпадать с вашим networking.hostName
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; }; # Передаем inputs в конфигурацию
      modules = [./configuration.nix ];
    };
  };
}
