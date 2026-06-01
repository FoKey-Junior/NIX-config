# 🧊 NixOS Configuration

![Background](https://github.com/user-attachments/assets/5a814f6a-6279-4249-9f70-4af1dc7b6138)

My personal **NixOS** config, tailored for development, daily use, and a bit of gaming.

The system was built to be a **stable yet bleeding-edge workstation** featuring KDE Plasma 6, NVIDIA, and a modern C++ toolchain.

---

## 🖥️ Core Specs

- **Bootloader:** systemd-boot (UEFI)
- **Kernel:** linuxPackages_latest
- **Desktop Environment:** KDE Plasma 6
- **Display Manager:** SDDM
- **Shell:** fish
- **Audio:** PipeWire (ALSA + PulseAudio compatibility)
- **Graphics:** NVIDIA (proprietary driver)
- **Network:** NetworkManager
- **Timezone:** Europe/Moscow
- **Locales:** `en_US.UTF-8` + `ru_RU.UTF-8`

---

## 🎨 Graphics & Desktop Environment

- KDE Plasma 6 (X11)
- Hyprland (included as an option)
- NVIDIA:
  - modesetting
  - power management
  - proprietary driver (`open = false`)

---

## 🔊 Audio

- PipeWire
- ALSA (including 32-bit support)
- PulseAudio via PipeWire
- RTKit for low latency

---

## 👤 User Configuration

- Standard user
- Groups: `wheel`, `networkmanager`
- Shell: **fish**
- KDE Software: Kate

---

## 🧰 Development (Main Focus)

### C / C++

- gcc, clang, llvm
- gdb, lldb
- cmake, ninja, gnumake
- pkg-config
- asio
- openssl
- libsodium
- sqlite
- rocksdb
- crow

### IDEs & Editors

- CLion
- Qt Creator
- VS Code / Cursor
- Arduino IDE

### Tools & Languages

- Git
- Python 3.15
- Node.js 24

---

## 🧑‍💻 CLI & Utilities

- htop, btop
- neofetch, fastfetch
- ranger
- eza
- tree
- kitty
- fish

---

## 🎮 Apps & Multimedia

- Steam (Remote Play + LAN)
- PrismLauncher
- Spotify
- Discord / Vesktop
- Telegram / AyuGram
- Obsidian
- Postman
- OBS Studio
- Bitwarden

---

## 🌐 Network & Services

- SSH Agent
- Printing (CUPS)
- Ngrok

---

## ❄️ Nix

- `allowUnfree = true`
- Experimental features:
  - `nix-command`
  - `flakes`
