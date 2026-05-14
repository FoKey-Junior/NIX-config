{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # === BOOT ===
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages;
  boot.blacklistedKernelModules = ["nouveau"];

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

  hardware.bluetooth.enable = true;

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

  services.displayManager.ly.enable = true;

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
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  services.printing.enable = true;

  # === USERS ===
  users.users.user = {
    isNormalUser = true;
    description = "user";

    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "dialout"
    ];

    packages = with pkgs; [];

    shell = pkgs.fish;
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
  programs.dconf.enable = true;
  programs.dconf.profiles.user.databases = [{
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  }];

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
  environment.variables = {
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    # terminal / launcher
    alacritty
    fuzzel

    # utils
    wget
    htop
    btop
    fastfetch
    ranger
    tree
    ncdu
    dysk
    libpqxx
    pciutils
    xwayland-satellite
    kdePackages.plasma-integration

    # archivers
    file-roller
    p7zip
    unzip
    unrar
    zip

    # dev tools
    clang
    cmake
    gcc
    gdb
    ninja
    gnumake
    git
    openssl
    nodejs_24
    python315
    postman
    jdk21_headless

    # editors / IDE
    vim
    neovim
    vscode
    antigravity
    code-cursor
    jetbrains.clion
    jetbrains.datagrip
    qtcreator
    arduino-ide

    # qt
    qt6.qtbase
    qt6.qttools
    qt6.qtdeclarative
    qt6.qtwayland

    # apps
    firefox
    telegram-desktop
    ayugram-desktop
    spotify
    obsidian
    obs-studio
    discord
    vesktop
    prismlauncher
    bitwarden-desktop
    anki
    nautilus
    eog

    # infra
    docker
    ngrok

    # === ТЕМЫ, ИКОНКИ И КУРСОРЫ ===
    nwg-look                  # Утилита для настройки внешнего вида

    # Темы GTK
    adw-gtk3                  # Тема в стиле libadwaita (GNOME)
    orchis-theme              # Популярная Material-тема
    catppuccin-gtk            # Пастельная тема Catppuccin

    # Иконки
    papirus-icon-theme        # Классические плоские иконки
    fluent-icon-theme         # Иконки в стиле Windows 11
    whitesur-icon-theme       # Иконки в стиле macOS
    tela-icon-theme           # Минималистичные плоские иконки

    # Курсоры
    bibata-cursors            # Отличный современный пак курсоров
    phinger-cursors           # Еще один качественный вариант
    apple-cursor              # Курсоры в стиле macOS
  ];

  # === FONTS ===
  fonts.packages = with pkgs; [
    # Моноширинные шрифты (для терминала и IDE)
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.ubuntu-mono
    cascadia-code

    # Системные шрифты (для интерфейса браузера, Telegram и т.д.)
    inter
    roboto
    noto-fonts

    # Иконки и эмодзи
    font-awesome
    noto-fonts-color-emoji
  ];

  fonts.fontconfig.defaultFonts = {
    serif = [ "Noto Serif" ];
    sansSerif = [ "Inter" "Roboto" "Noto Sans" ];
    monospace = [
      "JetBrainsMono Nerd Font"
      "Cascadia Code"
      "Noto Color Emoji"
    ];
    emoji = [ "Noto Color Emoji" ];
  };

  # === VERSION ===
  system.stateVersion = "25.11";
}

