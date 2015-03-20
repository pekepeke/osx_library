#!/bin/bash
# vim:fdm=marker sw=2 ts=2 ft=sh expandtab:

exec > >(tee -a /tmp/homebrew-brewfile-$USER.log) 2>&1

# util functions {{{1
error() {
  echo $* 1>&2
}

is_executable() {
  which $1 >/dev/null 2>&1
  return $?
}

is_will_upgrade() {
  if [ -z "$1" ]; then
    error "invalid argument : $@"
    return 255
  fi

  if [ $(brew outdated | awk "\$1 == \"$1\" {print \$0}" |wc -l) -gt 0 ]; then
    return 0
  fi
  return 1
}

echo_is_will_upgrade() {
  is_will_upgrade "$@"
  echo $?
}

installed_brew() {
  if [ -n "$1" ]; then
    error "invalid argument : $@"
    return 255
  fi

  if brew info $1 | grep -qF "Not installed"; then
    return 0
  fi
  return 1
}

installed_cask() {
  if [ -n "$1" ]; then
    error "invalid argument : $@"
    return 255
  fi

  if brew cask info $1 | grep -qF "Not installed"; then
    return 0
  fi
  return 1
}

reload_gui() {
  killall Dock

  killall Finder
  sudo killall -KILL appleeventsd
}

# install homebrew {{{1
if ! is_executable xcode-select; then
  echo "please install Xcode.app" 1>&2
  exit 1
fi
xcode-select --install 1>/dev/null 2>&1
if ! is_executable brew; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew_prefix=$(brew --prefix)
[ -w $brew_prefix ] && sudo chown -R $USER $brew_prefix

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

# taps {{{1
brew tap homebrew/binary || true
# brew tap phinze/homebrew-cask || true
# brew tap phinze/cask || true
brew tap gapple/services || true
brew tap homebrew/dupes || true
brew tap homebrew/versions || true
brew tap homebrew/apache || true
brew tap homebrew/homebrew-php || true
brew tap pekepeke/homebrew-pekepeke || true
brew tap pekepeke/homebrew-pekepekecask || true

brew tap peco/peco
brew tap motemen/ghq

# update {{{1
brew update

# upgrade {{{1
if true; then
  # prepare upgrade {{{2
  will_upgrade_mysql=$(echo_is_will_upgrade mysql)
  will_upgrade_postgresql=$(echo_is_will_upgrade postgresql)
  will_upgrade_boot2docker=$(echo_is_will_upgrade boot2docker)
  timestamp=$(date +'%Y%m%d-%s')

  if [ "$will_upgrade_postgresql" = "0" ]; then
    pg_dumpall > /tmp/pg_dump-$(date +'%Y%m%d%d%H%M').sql
  fi

  # upgrade {{{2
  brew upgrade

  # afterexec upgrade {{{2
  if [ "$will_upgrade_mysql" = "0" ]; then
    launchctl stop homebrew.mxcl.mysql
    # mysql.server stop
    brew link mysql --overwrite
    launchctl start homebrew.mxcl.mysql

    mysql_upgrade
    sed -i 's/sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES/#\0/' $(brew --cellar mysql)/*/my.cnf
  fi
  if [ "$will_upgrade_postgresql" = "0" ]; then
    launchctl stop homebrew.mxcl.postgresql
    old_pgsql_bin=`dirname $(dirname $(which psql))/$(readlink -n $(which psql))`

    brew link postgres --overwrite

    new_pgsql_bin=`dirname $(dirname $(which psql))/$(readlink -n $(which psql))`
    if [ "$old_pgsql_bin" != "$new_pgsql_bin" ]; then
      if [ -e ${brew_prefix}/var/postgres.old ] ;then
        mv ${brew_prefix}/var/postgres.old ${brew_prefix}/var/postgres.${timestamp}
        tar zcvf ${brew_prefix}/var/postgres.${timestamp}.tar.gz ${brew_prefix}/var/postgres.${timestamp}
      fi
      mv ${brew_prefix}/var/postgres ${brew_prefix}/var/postgres.old
      initdb ${brew_prefix}/var/postgres
      pg_upgrade -D ${brew_prefix}/var/postgres -d ${brew_prefix}/var/postgres.old -b $old_pgsql_bin -B $new_pgsql_bin

      launchctl start homebrew.mxcl.postgresql
    fi
  fi
  if [ "$will_upgrade_boot2docker" = "0" ]; then
    boot2docker delete
    boot2docker download
    boot2docker init
  fi
fi


# brew packages {{{1
brew install caskroom/cask/brew-cask
brew install bdw-gc
brew install coreutils
brew install gettext
brew install readline
brew install automake
brew install autoconf
brew install cmake || true
brew install glib
brew install boost
brew install lua
brew install libtool
brew install libevent
brew install libgcrypt
brew install mcrypt
brew install pcre
brew install jpeg
brew install giflib
brew install libtiff
brew install libpng
brew install intltool
brew install fontconfig
brew install freetype

brew install rmtrash
brew install lv
brew install tmux
brew install reattach-to-user-namespace
brew install imagemagick
brew install the_silver_searcher
brew install ngrep
brew install nkf
brew install gnu-sed
brew install tree
brew install nmap
brew install wget
brew install w3m
brew install rlwrap
brew install webkit2png
brew install jpeg-turbo
brew install optipng
brew install nginx || true

brew install jq
brew install gh
brew install ghq
brew install peco
brew install migemogrep

brew install xcproj
brew install go
brew install mono

brew install git || true
brew install git-now --zsh-completion || true
brew install gibo || true
brew install mercurial || true
brew install subversion --unicode-path || true
brew install tig
brew install icdiff

brew install qt4
brew install sip
brew install python --framework
brew install python3 --framework
brew install pyqt

brew install sqlite
brew install mysql || true
brew install percona-toolkit
brew install sqlite || true
brew install mongodb || true
brew install elasticsearch || true
brew install boot2docker

brew install vim --with-lua --with-python --with-ruby || true

# __END__ {{{1
