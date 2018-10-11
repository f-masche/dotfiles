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

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


echo "Installing App Store Apps"
mas signin fabian.maschewski@kaiser-x.com
mas lucky xcode

echo "Installing global npm packages..."
npm install gulp -g

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Show the ~/Library folder
chflags nohidden ~/Library

echo "Bootstrapping complete"
