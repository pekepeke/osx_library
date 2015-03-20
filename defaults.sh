#!/bin/bash

# util funcitons {{{1
reload_gui() {
  killall Dock

  killall Finder
  sudo killall -KILL appleeventsd
}

# defaults {{{1

# memo bool = yes
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool yes
# memo bool = no
# defaults delete com.apple.finder _FXShowPosixPathInTitle

 # アプリケーションの「保存」ダイアログで、詳細な保存場所を指定できる「詳細表示」をデフォルトに設定
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Tabで全てのコントロールにフォーカスできるようになる
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# 拡張子を常に表示する
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# 隠しファイル表示
# defaults write com.apple.finder AppleShowAllFiles -bool YES

# ネットワーク経由時、.DS_Store の作成を抑制
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# サービスのコンテキストメニューで階層を作らないように
defaults write -g NSServicesMinimumItemCountForContextSubmenu -int 15

#Finderのパスバーの開始位置をホームフォルダに変更
#defaults write com.apple.finder PathBarRootAtHome -bool yes

# 現在の位置をフルパス表示
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool yes
# defaults delete com.apple.finder _FXShowPosixPathInTitle

# Show the ~/Library folder
chflags nohidden ~/Library

# QuickLook のテキスト選択を有効
defaults write com.apple.finder QLEnableTextSelection -bool true

# safari ウィングルウィンドウモード
defaults write com.apple.Safari TargetedClicksCreateTabs -bool true

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Dashboard 無効
defaults write com.apple.dashboard mcx-disabled -boolean true

# X11 click
defaults write org.x.x11 wm_click_through -bool true

# dock の背景を半透明に
defaults write com.apple.dock hide-mirror -bool true

# reload_gui

# __END__ {{{1
