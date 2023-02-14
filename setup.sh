#!/bin/bash

set -e

echo "Setting up dotfiles..."
# Install Plugin Managers

if [[ ! -d ~/.zplug ]]; then
	echo "Installing zplug"
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

if [[ ! -d ~/.vim/bundle/Vundle.vim ]]; then
	echo "Installing vundle for Vim"
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Install commonly used utilities

echo "Installing command-line tools"
brew install \
	ffmpeg \
	stow \
	mackup 

echo ""
echo ""
echo "Would you like to install MacOS apps as well?"
echo "Press any 'y' to install or press any other key to skip."

read confirm

if [[ $confirm == "y" || $confirm == "Y" ]]; then
	echo "Installing MacOS Apps via Brew"
	brew install \
		affinity-photo \
		affinity-designer \
		affinity-publisher \
		appcleaner \
		blender \
		cyberduck \
		charles \
		dbeaver-community \
		discord \
		docker \
		epic-games \
		firefox \
		godot \
		gray \
		hiddenbar \
		istat-menus \
		jetbrains-toolbox \
		krita \
		linear-linear \
		multipass \
		obsidian \
		onyx \
		podman \
		raycast \
		rectangle \
		sim-daltonism \
		slack \
		spotify \
		steam \
		sublime-merge \
		sublime-text \
		the-unarchiver \
		tunnelblick \
		visual-studio-code \
		vlc \
		xcodes

	echo "You will need to manually install these apps from the app store or using their latest installer:"
	echo "Arduino IDE, Davinci Resolve,, GoodNotes, MindNode, One Thing, PDF Squeezer, Parallels Desktop 15, Screens 4, Shottr"
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
	# Disable natural scroll direction

	#  Currently Bugged
	# defaults write -globalDomain com.apple.swipescrolldirection 0
	# defaults write -globalDomain com.apple.trackpad.scaling 1

	# defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick 2
	# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick 2
	# defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick 0
	# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick 0

	# defaults write -globalDomain AppleInterfaceStyle Dark

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
stow mackup
popd

echo ""
echo ""
echo "Would you like to set Application Defaults using mackup?"
echo "Press any 'y' to restore or press any other key to skip."
if [[ $confirm == "y" || $confirm == "Y" ]]; then
	mackup restore
fi
