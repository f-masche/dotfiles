echo "Starting bootstrapping"

# get sudo for all the things
sudo -v

if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

PACKAGES=(
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
  mas
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

echo "Installing cask apps..."
CASKS=(
  atom
  docker
  firefox
  gimp
  iterm2
  slack
  spotify
  tower
  virtualbox
  franz
)

brew cask install ${CASKS[@]}

echo "Installing fonts..."
FONTS=(
    font-dejavu-sans
)

brew tap caskroom/fonts
brew cask install ${FONTS[@]}

# final brew upgrade
brew upgrade

echo "Installing atom packages..."
ATOM_PACKAGES=(
  vim-mode-plus
  atom-beautify
  atom-typescript
  linter-tslint
  linter
  pigments
)

apm install ${CASKS[@]}

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Installing vim plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing App Store Apps"
read -p "Enter Apple ID email: " appleEmail
mas signin --dialog $appleEmail
mas lucky xcode
mas lucky bear

echo "Installing global npm packages..."
npm install gulp -g

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Show the ~/Library folder
chflags nohidden ~/Library

# Linking config
CONFIG_FILES=(
  .zshrc
  .gitconfig
  .vimrc
  .vim
)

echo "Linking config..."
for file in "${CONFIG_FILES[@]}"
do
  if ! [ -f "${HOME}/${file}" ]; then
    ln -s $PWD/$file $HOME/$file
  fi
done

echo "Bootstrapping complete"
