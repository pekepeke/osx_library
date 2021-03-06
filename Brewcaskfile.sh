#!/bin/bash

# cask packages {{{1
# browser {{{2
brew cask install firefox
# brew cask install chromium
brew cask install google-chrome

# runtime {{{2
# brew cask install silverlight
brew cask install java
# brew cask install flash
# brew cask install flip4mac
# brew cask install adobe-air
# brew cask install easysimbl

# file {{{2
if [ -n "$DESKTOP" ]; then
  brew cask install dropbox
  brew cask install google-drive
fi

# communication {{{2
# cask install join-me
# brew cask install skype

# utilities {{{2
# cask install keyremap4macbook
# brew cask install clamxav
# brew cask install karabiner # dead
brew cask install karabiner-elements
# brew cask install xtrafinder
brew cask install bettertouchtool
# brew cask install alfred
# brew cask install flashlight
# brew cask install flashlighttool
brew cask install google-japanese-ime
# brew cask install menumeters # dead
brew cask install yujitach-menumeters
# brew cask install slate # dead
# brew cask install accessmenubarapps # dead
# brew cask install dash
if [ -n "$DESKTOP" ]; then
  brew cask install geektool
fi

# brew cask install takemepop
# brew cask install clipmenu # dead
brew cask install clipy
brew cask install appcleaner

brew cask install zipeg
brew cask install keka

brew cask install hardcore-zipper
brew cask install macwinzipper
brew cask install the-unarchiver

brew cask install caffeine
# brew cask install timemachineeditor
# brew cask install day-o
brew cask install grandperspective
brew cask install xquartz
brew cask install dupscanub
brew cask install disk-inventory-x
# brew cask install magican
# brew cask install permanent-eraser
# brew cask install tnef-s-enough
# brew cask install key-codes
# Tesm
brew cask install growl-fork

## Multimedia {{{2
if [ -n "$DESKTOP" ]; then
  brew cask install vlc
  brew cask install music-manager
  brew cask install radiant-player
  brew cask install google-music-manager
fi
# brew cask install handbrake
# brew cask install skitch
# brew cask install xnviewmp
# brew cask install gravit
# TODO : https://dribbble.com/shots/1582290-PSD-to-PNG-Automator-Action
  # brew cask install tomahawk
  # cask install google-music
  # brew cask install atraci

# own packages {{{2
# TODO : mojave
brew cask install macvim
# brew cask install macvim-kaoriya-custom
# brew cask install zeal
# brew cask install kdiff3-ja

## Editor {{{2
brew cask install coteditor
brew cask install visual-studio-code
  brew cask install textmate
# if [ -n "$DESKTOP" ]; then
# fi
# brew cask install intellij-idea-ce
# brew cask install unity3d
# brew cask install textwrangler
# cask install nethackcocoa
# macvim-kaoriya
# cask install sublime-text
# emacs

brew cask install 0xed

# brew cask install nvalt
# brew cask install livediag
# cask install lightpaper
# cask install haroopad
# brew cask install libreoffice
brew cask install freemind

## Dev Tools {{{2
brew cask install iterm2
brew cask install diffmerge
# brew cask install p4merge
# brew cask install stroy
brew cask install virtualbox
brew cask install vagrant
# brew cask install kitematic

brew cask install cyberduck
# brew cask install charles
brew cask install sequel-pro
# brew cask install pg-commander
# brew cask install psequel
# brew cask install astah-community
# brew cask install dbeaver-community
# brew cask install robomongo
# brew cask install pixus
# brew cask install sim-pholders2
# brew cask install simulator-manager
# brew cask install iexplorer
# brew cask install speedlimit

# cask install reveal
# brew cask install google-web-designer
# brew cask install pingendo
# brew cask install origami-studio
# brew cask install rapid-svn
brew cask install sourcetree
# brew cask install img2icns
brew cask install integrity
brew cask install sitesucker

# brew cask install platypus
# brew cask install fluid
# brew cask install genymotion

# gifzo
# brew cask install keepassx
# brew cask install macpass
if [ -n "$DESKTOP" ]; then
  brew cask install phoneclean
  brew cask install 1password
fi

# quicklook {{{2
brew cask install qlcolorcode
brew cask install qlstephen
brew cask install quicklook-json
brew cask install qlprettypatch
brew cask install quicklook-csv
# brew cask install betterzipql # dead?
# brew cask install webp-quicklook # dead?
brew cask install suspicious-package
brew cask install qlimagesize
# cask install qlmarkdown
brew cask install multimarkdown-qlgenerator
brew cask install fjn-web-archive-ql
# brew cask install thong-ql # dead?
brew cask install ql-sqlite3
brew cask install provisionql

# colorpicker {{{2
brew cask install colorpicker-skalacolor
brew cask install colorpicker-propicker

# Memo {{{1
cat <<EOM
brew cask install cooviewer
brew cask install mplayer-osx-extended
EOM

