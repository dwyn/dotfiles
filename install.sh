



#!/bin/sh

set -e # -e: exit on error

if [ ! "$(command -v chezmoi)" ]; then
  bin_dir="$HOME/.local/bin"
  chezmoi="$bin_dir/chezmoi"
  if [ "$(command -v curl)" ]; then
    sh -c "$(curl -fsSL https://git.io/chezmoi)" -- -b "$bin_dir"
  elif [ "$(command -v wget)" ]; then
    sh -c "$(wget -qO- https://git.io/chezmoi)" -- -b "$bin_dir"
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi
else
  chezmoi=chezmoi
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
# exec: replace current process with chezmoi init
exec "$chezmoi" init --apply "--source=$script_dir"

################################################################################################
################################################################################################
# Loving this repo 😍 https://github.com/chimurai/dotfiles
# #!/bin/bash

# set -eufo pipefail

# echo ""
# echo "🤚  This script will setup .dotfiles for you."
# read -n 1 -r -s -p $'    Press any key to continue or Ctrl+C to abort...\n\n'


# # Install Homebrew
# command -v brew >/dev/null 2>&1 || \
#   (echo '🍺  Installing Homebrew' && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)")

# # Install Oh My Zsh
# if [ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]; then
#   (echo '💰  Installing oh-my-zsh' && yes | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)")
# fi

# # Install chezmoi
# command -v chezmoi >/dev/null 2>&1 || \
#   (echo '👊  Installing chezmoi' && brew install chezmoi)

# if [ -d "$HOME/.local/share/chezmoi/.git" ]; then
#   echo "🚸  chezmoi already initialized"
#   echo "    Reinitialize with: 'chezmoi init https://github.com/chimurai/dotfiles.git'"
# else
#   echo "🚀  Initialize dotfiles with:"
#   echo "    chezmoi init https://github.com/chimurai/dotfiles.git"
# fi

# echo ""
# echo "Done."
