#!/bin/bash

set -e

echo "Setting up dotfiles..."


# Install brew if not already installed
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi


# Install Plugin Managers
if [[ ! -d ~/.local/share/zinit/zinit.git ]]; then
	echo "Installing zinit"
	bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
fi

if [[ ! -d ~/.vim/bundle/Vundle.vim ]]; then
	echo "Installing vundle for Vim"
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Install commonly used utilities
echo "Installing command-line tools"
brew bundle --file ~/.dotfiles/brewfiles/utils.brewfile

echo ""
echo ""
echo "Would you like to install MacOS apps as well via Brew?"
echo "Press any 'y' to install or press any other key to skip."

read confirm

if [[ $confirm == "y" || $confirm == "Y" ]]; then
	echo "Installing MacOS Apps via Brew"
	mkdir -p ~/.dotfiles/.brewtemp/
	
	echo -n "Install Utilities? " && read confirm
	if [[ $confirm == "y" || $confirm == "Y"  || $confirm == "" ]]; then
		touch ~/.dotfiles/.brewtemp/.install-utils
	fi

	echo -n "Install Browsers? " && read confirm
	if [[ $confirm == "y" || $confirm == "Y"  || $confirm == "" ]]; then
		touch ~/.dotfiles/.brewtemp/.install-browsers
	fi

	echo -n "Install Photo Apps? " && read confirm
	if [[ $confirm == "y" || $confirm == "Y"  || $confirm == "" ]]; then
		touch ~/.dotfiles/.brewtemp/.install-photo
	fi

	echo -n "Install Dev Tools? " && read confirm
	if [[ $confirm == "y" || $confirm == "Y"  || $confirm == "" ]]; then
		touch ~/.dotfiles/.brewtemp/.install-devtools
	fi

	echo -n "Install Gamedev Tools? " && read confirm
	if [[ $confirm == "y" || $confirm == "Y"  || $confirm == "" ]]; then
		touch ~/.dotfiles/.brewtemp/.install-gamedev
	fi

	echo -n "Install Chat Apps? " && read confirm
	if [[ $confirm == "y" || $confirm == "Y"  || $confirm == "" ]]; then
		touch ~/.dotfiles/.brewtemp/.install-chat
	fi

	echo -n "Install Productivyt Apps? " && read confirm
	if [[ $confirm == "y" || $confirm == "Y"  || $confirm == "" ]]; then
		touch ~/.dotfiles/.brewtemp/.install-productivity
	fi

	echo -n "Install Entertainment Apps? " && read confirm
	if [[ $confirm == "y" || $confirm == "Y"  || $confirm == "" ]]; then
		touch ~/.dotfiles/.brewtemp/.install-entertainment
	fi

	echo "Install apps that require the Mac App Store?"
	echo -n  "You will need to be signed in to the Mac App Store for this to work. "
	read confirm
	if [[ $confirm == "y" || $confirm == "Y"  || $confirm == "" ]]; then
		touch ~/.dotfiles/.brewtemp/.install-mas
	fi

	brew bundle --file ~/.dotfiles/brewfiles/apps.brewfile || true
	brew bundle --file ~/.dotfiles/brewfiles/appstore-apps.brewfile || true

	echo "You will need to manually install these apps from the app store or using their latest installer:"
	echo "Davinci Resolve, Parallels Desktop 15"

	rm -rf ~/.dotfiles/.brewtemp/
else
	echo "Skipping app install..."
fi

echo ""
echo ""
echo "Would you like to set the Mac Defaults?"
echo "Press any 'y' to install or press any other key to skip."

read confirm

if [[ $confirm == "y" || $confirm == "Y" ]]; then

	# Setup system preferences
	# Checkout settings here:
	# 	https://github.com/pawelgrzybek/dotfiles/blob/master/setup-macos.sh
	# 	https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/

	# Setup dock
	defaults write com.apple.dock minimize-to-application -bool true
	defaults write com.apple.dock autohide -bool true
	defaults write com.apple.dock show-process-indicators -bool true
	defaults write com.apple.dock tilesize -int 72
	defaults write com.apple.dock largesize -int 100

	defaults write com.apple.finder FXDefaultSearchScope SCcf
	defaults write com.apple.finder ShowExternalHardDrivesOnDesktop 0
	defaults write com.apple.finder ShowHardDrivesOnDesktop 0
	defaults write com.apple.finder ShowMountedServersOnDesktop 0
	defaults write com.apple.finder ShowRemovableMediaOnDesktop 0
fi

# Setup Theming
echo "Installing fonts"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh || true
cd ..
rm -rf fonts

echo ""
echo "Copying Color Them for Xcode..."
mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
cp ~/.dotfiles/themes/Gruvbox.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
defaults write com.apple.dt.Xcode XCFontAndColorCurrentDarkTheme Gruvbox.xccolortheme

echo "Set up the terminal theme by running 'open ~/.dotfiles/themes/Gruvbox.terminal' and set it as the default Terminal in preferences"

# Finish!
echo ""
echo "'stow'ing Dotfiles"
pushd ~/.dotfiles
stow vim
stow zsh
stow git
stow mackup
popd

echo ""
echo ""
echo "Would you like to set Application Defaults using mackup?"
echo "Press any 'y' to restore or press any other key to skip."
if [[ $confirm == "y" || $confirm == "Y" ]]; then
	mackup restore
fi
