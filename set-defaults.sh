#!/usr/bin/env bash
# Sets reasonable macOS defaults.
#
# Or, in other words, set shit how I like in macOS.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/nunorafaelrocha/dotfiles/blob/main/macos/set-defaults.sh
#   https://macos-defaults.com/
#
# Run ./set-defaults.sh and you'll be good to go.

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

if [ "$CI" != "true" ]; then
	# Ask for the administrator password upfront
	sudo -v

	# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi


###############################################################################
# General UI/UX                                                               #
###############################################################################

# Display battery percentage.
defaults write com.apple.menuextra.battery ShowPercent YES

# Autohide the dock
defaults write com.apple.dock "autohide" -bool "true"

# Specify dock tilesize
defaults write com.apple.dock "tilesize" -int "64"


# Set autohide-delay to 0 for blazingly fast dock
defaults write com.apple.dock "autohide-delay" -float "0"

# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false


###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Enable "natural" scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages "en"
defaults write NSGlobalDomain AppleLocale -string "en_GB@currency=EUR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Personal trackpad settings
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DragLock 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad HIDScrollZoomModifierMask 262144
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFiveFingerPinchGesture 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerPinchGesture 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadHandResting 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadHorizScroll 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadMomentumScroll 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadPinch 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRotate 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadScroll 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerDoubleTapGesture 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerFromRightEdgeSwipeGesture 3
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad USBMouseStopsTrackpad 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad UserPreferences 1


###############################################################################
# Screenshots                                                                 #
###############################################################################

# Copy screenshots straight into your clipboard
defaults write com.apple.screencapture location clipboard


###############################################################################
# Finder                                                                      #
###############################################################################

# Show all file extensions inside the Finder
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

# Show path bar
defaults write com.apple.finder "ShowPathbar" -bool "true"

# Column view
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"

# Keep folders on top
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"

# Remove the delay when hovering the toolbar title
defaults write NSGlobalDomain "NSToolbarTitleViewRolloverDelay" -float "0"


###############################################################################
# Menu Bar                                                                    #
###############################################################################

# Set dateformat
defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE d MMM HH:mm\""


###############################################################################
# Mission Control                                                             #
###############################################################################

# Disable automatic rearranging of Desktops/Windows (formerly known as Spaces) based on recent usage
defaults write com.apple.dock "mru-spaces" -bool "false"


###############################################################################
# TextEdit                                                                    #
###############################################################################

# Disabling Rich text
defaults write com.apple.TextEdit "RichText" -bool "false"


###############################################################################
# iTerm                                                                       #
###############################################################################

# Don't display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Calendar" \
	"cfprefsd" \
	"Dock" \
	"Finder" \
	"SystemUIServer" \
	"Terminal" ; do
	killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."