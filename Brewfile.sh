#!/bin/sh
# vim:fdm=marker sw=2 ts=2 ft=sh expandtab:

# util functions {{{1
error() {
  echo $* 1>&2
}

is_executable() {
  which $1 >/dev/null 2>&1
  return $?
}

is_will_upgrade() {
  if [ -n "$1" ]; then
    error "invalid argument : $@"
    return 255
  end

  if [ $(brew outdated | awk "$1 == '$1' {print $0}" |wc -l) -gt 0 ]; then
    return 0
  end
  return 1
}

echo_is_will_upgrade() {
  is_will_upgrade "$@"
  echo $?
}

is_installed() {
  if [ -n "$1" ]; then
    error "invalid argument : $@"
    return 255
  end

  if [ $(brew list | awk "$1 == '$1' {print $0}" |wc -l) -gt 0 ]; then
    return 0
  end
  return 1
}


# taps {{{1
brew tap homebrew/binary || true
brew tap phinze/homebrew-cask || true
brew tap homebrew/dupes || true
brew tap homebrew/versions || true
brew tap homebrew/apache || true
brew tap homebrew/homebrew-php || true
brew tap pekepeke/homebrew-pekepeke || true
brew tap phinze/cask || true
brew tap pekepeke/homebrew-pekepekecask || true

# update {{{1
brew update

# upgrade {{{1
if true; then
  # prepare upgrade {{{2
  local brew_prefix=$(brew --prefix)
  local will_upgrade_mysql=$(echo_is_will_upgrade mysql)
  local will_upgrade_postgresql=$(echo_is_will_upgrade postgresql)
  local timestamp=$(date +'%Y%m%d-%s')

  if [ $will_upgrade_postgresql -eq 0 ]; then
    pg_dumpall > /tmp/pg_dump-$(date +'%Y%m%d%d%H%M').sql
  fi

  # upgrade {{{2
  brew upgrade

  # afterexec upgrade {{{2
  if [ $will_upgrade_mysql -eq 0 ]; then
    launchctl stop homebrew.mxcl.mysql
    # mysql.server stop
    brew link mysql --overwrite
    launchctl start homebrew.mxcl.mysql

    mysql_upgrade
    sed -i 's/sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES/#\0/' $(brew --cellar mysql)/*/my.cnf
  fi
  if [ $will_upgrade_postgresql -eq 0 ]; then
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
fi


# brew packages {{{1
brew install brew-cask
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
brew install jq
brew install rlwrap
brew install webkit2png
brew install jpeg-turbo
brew install optipng
brew install vim --with-lua --with-python --with-ruby || true
brew install nginx || true

brew install git || true
brew install git-now --zsh-completion || true
brew install gibo || true
brew install mercurial || true
brew install subversion --unicode-path || true
brew install tig

brew install qt4
brew install sip
brew install python --framework
brew install pyqt

brew install sqlite
brew install mysql || true
brew install sqlite || true
brew install mongodb || true
brew install elasticsearch || true

# cask packages {{{1
# browser {{{2
brew cask install firefox
brew cask install chromium
# brew cask install google-chrome

# runtime {{{2
brew cask install silverlight
brew cask install java
brew cask install flash
brew cask install flip4mac
brew cask install adobe-air
brew cask install easysimbl

# file {{{2
brew cask install dropbox
brew cask install google-drive

# communication {{{2
# cask install join-me
brew cask install skype

# utilities {{{2
# cask install keyremap4macbook
brew cask install clamxav
brew cask install karabiner
brew cask install xtrafinder
brew cask install bettertouchtool
brew cask install alfred
brew cask install google-japanese-ime

brew cask install takemepop
brew cask install clipmenu
brew cask install appcleaner

brew cask install ziipeg
brew cask install keka
brew cask install hardcore-zipper
brew cask install macwinzipper

brew cask install caffeine
brew cask install timemachineeditor
brew cask install day-o
brew cask install grandperspective
brew cask install xquartz
brew cask install dupscanub
brew cask install disk-inventory-x
# kypass companion -> mac app store

## Multimedia {{{2
brew cask install vlc
brew cask install tomahawk
# cask install google-music
brew cask install radiant-player
brew cask install google-music-manager
brew cask install handbrake
brew cask install skitch
brew cask install xnviewmp
brew cask install gravit
# TODO : https://dribbble.com/shots/1582290-PSD-to-PNG-Automator-Action
# TODO : http://getatraci.net/

## Editor {{{2
brew cask install coteditor
brew cask install textmate
brew cask install intellij-idea-ce
brew cask install unity3d
# cask install nethackcocoa
# macvim-kaoriya
# cask install sublime-text
# emacs

brew cask zeroxed

brew cask install nvalt
brew cask install livediag
# cask install lightpaper
# cask install haroopad
brew cask install libreoffice

## Dev Tools {{{2
brew cask install iterm2
brew cask install diffmerge
brew cask install p4merge
brew cask install stroy
brew cask install virtualbox
brew cask install vagrant

brew cask install cyberduck
brew cask install charles
brew cask install sequel-pro
brew cask install pg-commander
brew cask install robomongo
brew cask install pixus
brew cask install sim-pholders2

# cask install reveal
brew cask install google-web-designer
brew cask install rapid-svn
brew cask install sourcetree
brew cask install img2icns

brew cask install platypus

# gifzo
brew cask install phoneclean
# brew cask install keepassx
brew cask install macpass

# quicklook {{{2
brew cask install qlcolorcode
brew cask install qlstephen
brew cask install quicklook-json
brew cask install qlprettypatch
brew cask install quicklook-csv
brew cask install betterzipql
brew cask install webp-quicklook
brew cask install suspicious-package
brew cask install qlimagesize
# cask install qlmarkdown
brew cask install multimarkdown-qlgenerator
brew cask install fjn-web-archive-ql
brew cask install thong-ql
brew cask install ql-sqlite3
brew cask install provisionql

# __END__ {{{1
