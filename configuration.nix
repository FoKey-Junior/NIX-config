{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # === BOOT ===
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages;

  # === NIX ===
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # === SYSTEM ===
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Moscow";

  # === LOCALES ===
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

  # === HARDWARE ===
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
  };

  # === GRAPHICS ===
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  programs.niri.enable = true;
  programs.xwayland.enable = true;

  # === AUDIO ===
  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.rtkit.enable = true;

  # === SERVICES ===
  services.printing.enable = true;

  # === USERS ===
  users.users.user = {
    isNormalUser = true;
    description = "user";

    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];

    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # === SHELLS ===
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

  # === PROGRAMS ===
  programs.firefox.enable = true;

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

  # === VIRTUALIZATION ===
  virtualisation.docker.enable = true;

  # === PACKAGES ===
  environment.systemPackages = with pkgs; [

    # utils
    wget
    htop
    btop
    fastfetch
    ranger
    tree
    ncdu
    unzip
    libpqxx

    # terminal / launcher
    alacritty
    fuzzel

    # dev tools
    clang
    cmake
    gdb
    ninja
    gnumake
    git
    openssl
    nodejs_24
    python315

    # editors / IDE
    vim
    neovim
    vscode
    code-cursor
    jetbrains.clion
    qtcreator

    # qt
    qt6.qtbase
    qt6.qttools
    qt6.qtdeclarative
    qt6Packages.qt6ct

    # apps
    arduino-ide
    telegram-desktop
    ayugram-desktop
    spotify
    obsidian
    discord
    vesktop
    prismlauncher
    bitwarden-desktop
    postman

    # infra
    docker
    ngrok
  ];

  # === FONTS ===
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    font-awesome
    noto-fonts
    noto-fonts-color-emoji
    cascadia-code
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = [
      "Cascadia Code"
      "Noto Color Emoji"
    ];
  };

  # === VERSION ===
  system.stateVersion = "25.11";
}
