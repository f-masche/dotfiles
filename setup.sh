set -e

readonly BREW_PACKAGES=(
  cmake
  curl
  git
  htop
  npm
  nvm
  python
  python3
  tree
  vim
  bat
  ack
  zsh
)

readonly HOMEBREW_CASKS=(
  vscodium
  docker
  firefox
  iterm2
  slack
  spotify
  tower
  virtualbox
  franz
  font-dejavu-sans
  font-dejavusansmono-nerd-font
)

readonly NPM_PACKAGES=(
  gulp
  yarn
)

readonly CONFIG_FILES=(
  .zshrc
  .gitconfig
  .vimrc
  .vim
)

readonly VSCODE_EXTENSIONS=(
  Angular.ng-template
  christian-kohler.npm-intellisense
  christian-kohler.path-intellisense
  CoenraadS.bracket-pair-colorizer-2
  dariofuzinato.vue-peek
  dbaeumer.vscode-eslint
  eg2.vscode-npm-script
  esbenp.prettier-vscode
  formulahendry.auto-close-tag
  formulahendry.auto-rename-tag
  glen-84.sass-lint
  mubaidr.vuejs-extension-pack
  octref.vetur
  rbbit.typescript-hero
  robinbentley.sass-indented
  shd101wyy.markdown-preview-enhanced
  tombonnike.vscode-status-bar-format-toggle
  vscodevim.vim
  tinkertrain.theme-panda
)

readonly VSCODE_CONFIG_FILES=(
  settings.json
  keybindings.json
  snippets
)

function install_homebrew {
  if test ! $(command -v brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

function homebrew_install {
  echo "Installing homebrew packages..."
  brew install ${BREW_PACKAGES[@]}

  echo "Installing homebrew cask apps..."
  brew tap homebrew/cask-fonts
  brew cask install ${HOMEBREW_CASKS[@]}

  echo "Cleaning up..."
  brew cleanup

  echo "Upgrading homebrew..."
  brew upgrade
}

function install_bat_theme {
  echo "Installing bat theme..."
  mkdir -p ~/Library/Preferences/bat/themes/dracula
  wget https://raw.githubusercontent.com/dracula/sublime/8d2df907bd83da857fb850e491b748918a35f1cc/Dracula.tmTheme -O ~/Library/Preferences/bat/themes/dracula/Dracula.tmTheme
  bat cache --build
}

function install_oh_my_zsh {
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

function install_vim_plug {
  echo "Installing vim plug..."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

function install_global_npm {
  echo "Installing global npm packages..."
  npm install ${NPM_PACKAGES[@]} -g
}

function configure_system {
  echo "Setting up system configuration..."
  # When performing a search, search the current folder by default
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  # Show the ~/Library folder
  chflags nohidden ~/Library
}

function link_config_files {
  echo "Linking config..."
  for file in "${CONFIG_FILES[@]}"
  do
    if ! [ -e "${HOME}/${file}" ]; then
      ln -s "${PWD}/${file}" "${HOME}/${file}"
    fi
  done
}

function configure_vscode {
  if test ! $(command -v code); then
    echo "Linking vscode..."
    ln -s  /Applications/VSCodium.app/Contents/Resources/app/bin/code \
        /usr/local/bin/code
  fi

  echo "Installing vscode extensions..."

  for extension in "${VSCODE_EXTENSIONS[@]}"
  do
    code --install-extension --force $extension
  done

  echo "Linking vscode settings..."
  for file in "${VSCODE_CONFIG_FILES[@]}"
  do
    dest="$HOME/Library/Application Support/VSCodium/User/$file"
    rm -rf "$dest"
    ln -s "$PWD/VSCode/$file" "$dest"
  done
}

echo "Starting bootstrapping"

sudo -v

install_homebrew
homebrew_install
install_bat_theme
install_oh_my_zsh
install_vim_plug
install_global_npm
configure_system
link_config_files
configure_vscode

echo "Bootstrapping complete"
