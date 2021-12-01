set -e

readonly BREW_PACKAGES=(
  cmake
  curl
  htop
  npm
  nvm
  python
  python3
  tree
  nvim
  bat
  ack
  ffmpeg
  gifsicle
  mas
  fzf
)

readonly APP_STORE_APPS=(
  1289583905 # Pixelmator Pro
  409201541  # Pages
)

readonly HOMEBREW_CASKS=(
  spotify
  font-dejavu-sans-mono-nerd-font
)

readonly NPM_PACKAGES=(
  typescript
  typescript-language-server
  diagnostic-languageserver
  eslint_d
)

readonly CONFIG_FILES=(
  .zshrc
  .gitconfig
  .local-env
)


function install_app_store_apps {
  mas install ${APP_STORE_APPS[@]}
}

function install_rust {
  if test ! $(command -v rustc); then
    echo "Installing rust"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi
}

function install_xcode_tools {
  if test ! $(command -v make); then
    echo "Installing xcode tools"
    xcode-select --install
  fi
}

function install_homebrew {
  if test ! $(command -v brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

function homebrew_install {
  echo "Installing homebrew packages..."

  for package in "${BREW_PACKAGES[@]}"
  do
    echo "Installing ${package}"
    if brew list $package > /dev/null; then
      echo "${package} is already installed"
    else
      brew install $package
    fi
  done

  echo "Installing homebrew cask apps..."
  brew tap homebrew/cask-fonts

  for cask in "${HOMEBREW_CASKS[@]}"
  do
    echo "Installing ${cask}"
    if brew list --cask $cask > /dev/null; then
      echo "${cask} is already installed"
    else
      brew install --cask $cask
    fi
  done

  echo "Cleaning up..."
  #brew cleanup

  echo "Upgrading homebrew..."
  #brew upgrade
}

function install_oh_my_zsh {
  echo "Installing oh-my-zsh..."
  if ! [ -e "${HOME}/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi
}

function setup_vim {
  echo "Setup vim..."
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  pip3 install neovim
  local initVimFile="${HOME}/.config/nvim/init.vim"
  if ! [ -e $initVimFile ]; then
    rm $initVimFile
  fi
  ln -s "${PWD}/init.vim" $initVimFile
}

function install_global_npm {
  echo "Installing global npm packages..."
  npm install ${NPM_PACKAGES[@]} -g
}

function configure_sublime {
  echo "Configuring sublime..."
  cp -rf ./sublime/* "${HOME}/Library/Application Support/Sublime Text/Packages/User/"
}

function configure_system {
  echo "Setting up system configuration..."
  # When performing a search, search the current folder by default
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  # Set fast key repeat rate
  defaults write NSGlobalDomain KeyRepeat -int 0

  # Show the ~/Library folder
  chflags nohidden ~/Library

  # Enable tap-to-click
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

  # Disable mouse acceleration
  defaults write -g com.apple.mouse.scaling -integer -1
}

function link_config_files {
  echo "Linking config..."
  for file in "${CONFIG_FILES[@]}"
  do
    if ! [ -e "${HOME}/${file}" ]; then
      echo "Linking ${file}"
      ln -s "${PWD}/${file}" "${HOME}/${file}"
    fi
  done
}

function install_fzf {
  echo "Installing fzf..."
  if ! [ -e "${HOME}/.fzf.zsh" ]; then
    $(brew --prefix)/opt/fzf/install
  fi
}

echo "Starting bootstrapping"

sudo -v

install_homebrew
install_xcode_tools
homebrew_install
install_oh_my_zsh
install_app_store_apps
install_global_npm
install_fzf
setup_vim
configure_system
link_config_files
configure_sublime
install_rust

echo "Bootstrapping complete"
