{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Time & Locale
  time.timeZone = "Europe/Moscow";

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

  # Display / Desktop
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
  };

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing
  services.printing.enable = true;

  # User
  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "networkmanager" "wheel" "docker" ];

    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Programs
  programs.firefox.enable = true;
  programs.niri.enable = true;
  programs.fish.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
  };

  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Virtualisation
  virtualisation.docker.enable = true;

  # Packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # CLI
    wget 
    htop 
    btop
    fastfetch
    ranger
    tree
    ncdu
    unzip

    # Dev
    clang 
    cmake
    gdb
    python315
    git 
    vim
    neovim
    openssl
    ninja
    gnumake
    nodejs_24

    # Terminal / UI
    fuzzel
    alacritty
    waybar
    gtk4
    rofi

    # Apps
    arduino-ide
    telegram-desktop
    ayugram-desktop
    spotify obsidian
    jetbrains.clion
    discord
    vesktop
    prismlauncher
    code-cursor
    vscode
    bitwarden-desktop
    postman
    qtcreator
    ngrok
    docker
  ];

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    font-awesome
    noto-fonts
    noto-fonts-color-emoji
    cascadia-code
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = [ "Cascadia Code" "Noto Color Emoji" ];
  };

  system.stateVersion = "25.11";
}
