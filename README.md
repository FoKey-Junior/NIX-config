# 🧊 NixOS Configuration

Мой персональный конфиг **NixOS**, ориентированный на разработку, повседневное использование и немного гейминга

Система собиралась как **стабильный, но максимально свежий workstation** с KDE Plasma 6, NVIDIA и современным стеком инструментов для C++

---

## 🖥️ Основные характеристики

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

## 🎨 Графика и окружение

- KDE Plasma 6 (X11)
- Hyprland включён как опция
- NVIDIA:
    - modesetting
    - power management
    - proprietary driver (`open = false`)

---

## 🔊 Аудио

- PipeWire
- ALSA (включая 32-bit)
- PulseAudio через PipeWire
- RTKit для low-latency

---

## 👤 Пользователь

- Обычный пользователь
- Группы: `wheel`, `networkmanager`
- Shell: **fish**
- KDE-софт: Kate

---

## 🧰 Разработка (основной фокус)

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

### Инструменты

- CLion
- Qt Creator
- VS Code / Cursor
- Git
- Python 3.15
- Node.js 24

---

## 🧑‍💻 CLI & Utils

- htop, btop
- neofetch, fastfetch
- ranger
- eza
- tree
- kitty
- fish

---

## 🎮 Программы и мультимедиа

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

## 🌐 Сеть и прочее

- SSH Agent
- Printing (CUPS)
- Ngrok
- Arduino IDE

---

## ❄️ Nix

- `allowUnfree = true`
- Experimental features:
    - `nix-command`
    - `flakes`
