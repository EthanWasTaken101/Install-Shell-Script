#!/usr/bin/env bash
#
# General-purpose software installer for Arch Linux
# Select applications from the menu and install them with the native package manager.
#
set -Eeuo pipefail

DISTRO="Arch Linux"
PACKAGE_MANAGER="pacman"

on_error() {
    local exit_code=$?
    echo "An error occurred (exit code $exit_code). Review the package-manager output above." >&2
    exit "$exit_code"
}
trap on_error ERR

command -v pacman >/dev/null 2>&1 || { echo "This script requires pacman."; exit 1; }
command -v sudo >/dev/null 2>&1 || { echo "sudo is required. Install it or run this script as root after adapting the commands."; exit 1; }

declare -A packages
packages[1]="git"
packages[2]="curl"
packages[3]="wget"
packages[4]="htop"
packages[5]="neovim"
packages[6]="firefox"
packages[7]="vlc"
packages[8]="gimp"
packages[9]="libreoffice-fresh"
packages[10]="ffmpeg"

echo "=============================================="
echo " Arch Linux - Interactive Software Installer"
echo "=============================================="
echo "Choose one or more applications to install."
echo
cat <<'MENU'
 1) Git              6) Firefox
 2) curl             7) VLC
 3) wget             8) GIMP
 4) htop             9) LibreOffice
 5) Neovim          10) FFmpeg

Enter numbers separated by spaces or commas (e.g. 1 2 5).
Enter 'all' to select every listed application, or 'q' to quit.
MENU
echo

read -r -p "Your selection: " selection
if [[ "$selection" =~ ^[Qq]$ ]]; then
    echo "No changes made."
    exit 0
fi

declare -a selected_packages=()
declare -A seen=()

if [[ "$selection" == "all" || "$selection" == "ALL" ]]; then
    for key in {1..10}; do
        selected_packages+=("${packages[$key]}")
    done
else
    selection="${selection//,/ }"
    for choice in $selection; do
        if [[ ! "$choice" =~ ^([1-9]|10)$ ]]; then
            echo "Ignoring invalid selection: $choice" >&2
            continue
        fi
        if [[ -z "${seen[$choice]+x}" ]]; then
            selected_packages+=("${packages[$choice]}")
            seen[$choice]=1
        fi
    done
fi

if (( ${#selected_packages[@]} == 0 )); then
    echo "No valid applications selected. Nothing to install."
    exit 0
fi

echo
echo "The following packages will be installed:"
printf '  - %s\n' "${selected_packages[@]}"
echo
read -r -p "Continue? [y/N] " confirmation
if [[ ! "$confirmation" =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 0
fi

echo
echo "Starting installation using $PACKAGE_MANAGER..."
sudo pacman -Syu --needed --noconfirm "${selected_packages[@]}"

echo
echo "Installation command completed."
echo "Some applications may require logging out, restarting, or launching from your desktop menu."
