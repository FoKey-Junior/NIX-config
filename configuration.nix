{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # =====================
  # BOOTLOADER (FIXED)
  # =====================
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5;

  # Latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # =====================
  # NETWORKING
  # =====================
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";

  # =====================
  # LOCALE
  # =====================
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # =====================
  # GRAPHICS / DISPLAY
  # =====================
  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
  };

  # =====================
  # AUDIO
  # =====================
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # =====================
  # PRINTING
  # =====================
  services.printing.enable = true;

  # =====================
  # USERS
  # =====================
  users.users.user = {
    isNormalUser = true;
    description = "user";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # =====================
  # NIX SETTINGS
  # =====================
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # =====================
  # PROGRAMS
  # =====================
  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.hyprland.enable = true;
  programs.ssh.startAgent = true;
  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # =====================
  # SYSTEM PACKAGES
  # =====================
  environment.systemPackages = with pkgs; [
    wget
    htop
    btop
    neofetch
    fastfetch
    ranger
    fish
    eza
    kitty
    wofi
    eww
    swww
    tree

    gcc
    clang
    llvm
    lldb
    cmake
    gdb
    python315
    git
    vim
    neovim
    openssl
    ninja
    crow
    libsodium
    libsodium.dev
    sqlite
    openssl
    asio
    nodejs_24
    rocksdb
    gnumake
    pkg-config
    ngrok
    

    throne
    arduino-ide
    telegram-desktop
    ayugram-desktop
    spotify
    obsidian
    jetbrains.clion
    discord
    vesktop
    prismlauncher
    code-cursor
    vscode
    bitwarden-desktop
    postman
    qtcreator
  ];

  
  # =====================
  # STATE VERSION
  # =====================
  system.stateVersion = "25.11";
}

