#!/bin/bash

GIT_URL="git://github.com/pekepeke/osx_library"
LOCAL_DIR="$HOME/.osx_library"
opt_uninstall=0

usage() {
  prg_name=`basename $0`
  cat <<EOM
  Usage: $prg_name [-h]
EOM
  exit 1
}

trace() {
  echo $*
  $*
}

application_support_files() {
  find "Application Support" -depth 2
}

is_ignore() {
  if [ $f = "Preferences" ] ; then
    return 0
  elif [ $f = "tools" ] ; then
    return 0
  elif [ $f = "QuickLook" ] ; then
    return 0
  elif [ $f = "Application Support/BetterTouchTool/bttdata2" ]; then
    return 0
  fi
  return 1
}

other_files() {
  for f in $(ls .); do
    if [ $f = "Application Support" -o -f $f ]; then
      # echo "skip"
      continue
    elif is_ignore $f; then
      # do nothing
      # echo "ignore $f"
      continue
    elif [ -d $f ]; then
      for fp in $(find $f -type f); do
        echo $fp
      done
    fi
  done
}

apply_file() {
  local HOME_LIB="$HOME/Library"
  local SRC=$1
  local TARGET=$HOME_LIB/$1

  if [ x$opt_uninstall = x1 ]; then
    [ -L $TARGET ] && trace rm $TARGET
    [ -e "$TARGET.org" ] && trace mv "$TARGET.org" "$TARGET"
  else
    if [ -e "$TARGET.org" ]; then
      echo "skip : $SRC"
    elif [ ! -L $TARGET ]; then
      if [ -e "$TARGET" ]; then
        trace mv "$TARGET" "$TARGET.org"
      fi
      local PARENT=$(dirname $TARGET)
      [ ! -e $PARENT ] && trace mkdir -p $PARENT
      if [ -e "$TARGET" ]; then
        echo "skip : $SRC"
      else
        trace ln -s "$PWD/$SRC" "$TARGET"
      fi
    fi
  fi

}

main() {
  local cwd=$(pwd)

  if [ ! -e $(basename $0) ];then
    if [ ! -e $LOCAL_DIR ];then
      git clone ${GIT_URL} ${LOCAL_DIR}
    fi
    cd ${LOCAL_DIR}
  fi

  cd $(dirname $0)
  (
    IFS=$'\n';
    find . -name '.DS_Store' -exec rm {} \;
    for f in $(application_support_files); do
      apply_file $f
    done
    for f in $(other_files); do
      apply_file $f
    done
  )

  cd $cwd
}

while getopts "hvu" opt; do
  case $opt in
    h)
      usage ;;
    u)
      opt_uninstall=1;;
    # v) ;;
    # s)
    #   #$OPTARG
    #   ;;
  esac
done
shift `expr $OPTIND - 1`
if [ $OPT_ERROR ]; then
  usage
fi

main "$@"

