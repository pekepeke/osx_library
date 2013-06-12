#!/bin/bash

GIT_URL="git://github.com/pekepeke/osx_library"
LOCAL_DIR="$HOME/.osx_library"

usage() {
  prg_name=`basename $0`
  cat <<EOM
  Usage: $prg_name [-h]
EOM
  exit 1
}

main() {
  local cwd=$(pwd)

  if [ ! -e $LOCAL_DIR ];then
    git clone ${GIT_URL} ${LOCAL_DIR}
  fi
  cd ${LOCAL_DIR}

  ./lib/setup_library.sh
  ./lib/setup_prefs.sh -a
  ./lib/setup_custom_icon.pl

  cd $cwd
}

OPTIND_OLD=$OPTIND
OPTIND=1
while getopts "hvs:" opt; do
  case $opt in
    h)
      usage ;;
    v) ;;
    s)
      #$OPTARG
      ;;
  esac
done
shift `expr $OPTIND - 1`
OPTIND=$OPTIND_OLD
if [ $OPT_ERROR ]; then
  usage
fi

main "$@"

