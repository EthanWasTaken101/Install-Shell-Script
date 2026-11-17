# Install-Shell-Script

A collection of interactive Bash installers for 15 Linux distributions. Each script presents a menu of common applications and installs the selected software using the distribution's native package manager.

## Supported distributions

| Distribution | Script | Package manager |
|---|---|---|
| Ubuntu | `scripts/install-ubuntu.sh` | APT |
| Debian | `scripts/install-debian.sh` | APT |
| Linux Mint | `scripts/install-linux-mint.sh` | APT |
| Pop!_OS | `scripts/install-pop-os.sh` | APT |
| Fedora | `scripts/install-fedora.sh` | DNF |
| Red Hat Enterprise Linux | `scripts/install-rhel.sh` | DNF |
| Rocky Linux | `scripts/install-rocky-linux.sh` | DNF |
| Arch Linux | `scripts/install-arch-linux.sh` | Pacman |
| Manjaro | `scripts/install-manjaro.sh` | Pacman |
| openSUSE | `scripts/install-opensuse.sh` | Zypper |
| Alpine Linux | `scripts/install-alpine.sh` | APK |
| Void Linux | `scripts/install-void-linux.sh` | XBPS |
| Gentoo | `scripts/install-gentoo.sh` | Portage |
| NixOS | `scripts/install-nixos.sh` | Nix |
| AlmaLinux | `scripts/install-alma-linux.sh` | DNF |

## Available applications

1. Git
2. curl
3. wget
4. htop
5. Neovim
6. Firefox
7. VLC
8. GIMP
9. LibreOffice
10. FFmpeg

Package names can differ between distributions. The scripts map the menu selections to the package names used by each supported distribution.

## Usage

Clone the repository:

```bash
git clone https://github.com/EthanWasTaken101/Install-Shell-Script.git
cd Install-Shell-Script
```

Make the relevant script executable (if needed):

```bash
chmod +x scripts/install-ubuntu.sh
```

Run the script for your distribution. For example:

```bash
./scripts/install-ubuntu.sh
```

Choose one or more menu numbers separated by spaces or commas, such as `1 2 5`. Enter `all` to select every listed application, or `q` to quit. The script asks for confirmation before installing.

## Requirements and notes

- Bash 4 or newer is recommended (the scripts use associative arrays).
- Use the script matching your Linux distribution.
- Most scripts require `sudo` access. The NixOS script uses `nix profile` for the current user and does not use `sudo`.
- An internet connection and working package repositories are required.
- Some packages may be unavailable until optional repositories are enabled, or may have different names on a particular release.
- Review a script before running it. Package availability and package-manager behavior can change between distribution releases.
- The scripts do not add third-party repositories or install software from unofficial download sites.

## Safety

These scripts invoke the native package manager and request confirmation before making changes. They do not run remote install commands piped directly into a shell. You should still inspect scripts before executing them and understand that package installation changes your system.

## Contributing

Issues and pull requests are welcome. If you add a distribution, include its package-manager checks, package mappings, installation flow, and documentation.

## License

This project is licensed under the MIT License. See [LICENSE.md](LICENSE.md).
