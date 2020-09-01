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
  nvim
  bat
  ack
  zsh
  ffmpeg
  gifsicle
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
  font-dejavu-sans
  font-dejavusansmono-nerd-font
)

readonly NPM_PACKAGES=(
  yarn
  lerna
  gulp-cli
  tslint
  typescript
  @angular/cli
)

readonly CONFIG_FILES=(
  .zshrc
  .gitconfig
  .vimrc
  .vim
  .local-env
)

readonly VSCODE_EXTENSIONS=(
  Angular.ng-template
  bierner.markdown-preview-github-styles
  christian-kohler.npm-intellisense
  christian-kohler.path-intellisense
  CoenraadS.bracket-pair-colorizer-2
  dawhite.mustache
  dracula-theme.theme-dracula
  eamodio.gitlens
  eg2.vscode-npm-script
  glen-84.sass-lint
  Gruntfuggly.todo-tree
  mechatroner.rainbow-csv
  ms-vscode.vscode-typescript-tslint-plugin
  rbbit.typescript-hero
  robinbentley.sass-indented
  shd101wyy.markdown-preview-enhanced
  sleistner.vscode-fileutils
)

readonly VSCODE_CONFIG_FILES=(
  settings.json
  keybindings.json
  snippets
)

function install_rust {
  curl https://sh.rustup.rs -sSf
}

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

function install_fzf {
  echo "Installing fzf..."
  $(brew --prefix)/opt/fzf/install
}

echo "Starting bootstrapping"

sudo -v

install_homebrew
homebrew_install
install_bat_theme
install_oh_my_zsh
install_vim_plug
install_global_npm
install_fzf
configure_system
link_config_files
configure_vscode
install_rust

echo "Bootstrapping complete"
