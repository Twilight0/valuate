<p align="center">
  <img src="data/icons/hicolor/512x512/apps/org.x.valuate.png" width="128" alt="Valuate icon"/>
</p>

<h1 align="center">Valuate</h1>

<p align="center">
  A GTK3, XApp and Cinnamon-rebased calculator fork
</p>

<p align="center">
  <a href="https://github.com/Twilight0/valuate/releases">
    <img src="https://img.shields.io/github/v/release/Twilight0/valuate?include_prereleases" alt="Release">
  </a>
  <a href="https://aur.archlinux.org/packages/valuate-git">
    <img src="https://img.shields.io/aur/version/valuate-git" alt="AUR">
  </a>
  <a href="https://github.com/Twilight0/valuate/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/Twilight0/valuate" alt="License">
  </a>
</p>

---

## About

Valuate is a desktop calculator application forked from GNOME Calculator, rebased to use GTK3, XApp, and Cinnamon libraries for better integration with traditional desktop environments.

## Features

- **Basic, Advanced, Financial, and Programming modes**
- **Calculation history** with persistent storage across sessions
- **Clear History** button in the headerbar
- **Remember History** toggle in preferences
- **XApp integration** for native look and feel
- **GTK3 and Cinnamon theme support**

## Changes from GNOME Calculator

- Renamed from "Calculator" to "Valuate" throughout the application
- Updated window title, about dialog, and context menu
- New application icons with transparent backgrounds and shadow masking
- Added calculation history persistence
- Added Clear History button in headerbar
- Added Remember History toggle in preferences
- Rebased on XApp for Cinnamon desktop integration
- Removed old SVG icons in favor of PNG icons

## Dependencies

### Runtime

- `gtk3`
- `libhandy`
- `xapp`
- `gtksourceview4`
- `libsoup3`
- `libgee`
- `libmpc`
- `mpfr`

### Build

- `vala`
- `meson`
- `ninja`
- `git`

## Installation

### From AUR

```bash
yay -S valuate-git
# or
paru -S valuate-git
```

### Building from source

```bash
git clone https://github.com/Twilight0/valuate.git
cd valuate
meson setup build
meson compile -C build
sudo meson install -C build
```

### Building with makepkg (Arch Linux)

```bash
git clone https://github.com/Twilight0/valuate.git
cd valuate
makepkg -si
```

## License

GPLv3+
