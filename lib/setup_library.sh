#!/bin/bash

opt_uninstall=0
opt_dry_run=0

usage() {
  prg_name=`basename $0`
  cat <<EOM
  Usage: $prg_name [-h]

-h : show help
-u : uninstall
-d : dry run
EOM
  exit 1
}

trace() {
  echo $*
  if [ x$opt_dry_run = x0 ]; then
    $*
  fi
}

install_libraries() {
  local cwd=$(pwd)
  local here=$(cd $(dirname $0)/..;pwd)
  cd $here/Library
  (
    IFS=$'\n';
    find . -name '.DS_Store' -exec rm {} \;
    copy_application_support_files
    for f in $(copy_application_support_files); do
      SRC="$f"
      TARGET="$HOME/Library/$f"
      if [ x$opt_uninstall = x1 ]; then
        [ -e "$TARGET" ] && trace rm "$TARGET"
        [ -e "$TARGET.org" ] && trace mv "$TARGET.org" "$TARGET"
      else
        if [ ! -e "$TARGET.org" ]; then
          [ -e "$TARGET" ] && mv "$TARGET" "$TARGET.org"
          echo cp -rp "$SRC" "$TARGET"
          cp -rp "$SRC" "$TARGET"
        else
          echo "already exists: $TARGET"
        fi
      fi
    done
    # application_support_files
    for f in $(application_support_files); do
      apply_library_file $f
    done
    for f in $(other_library_files); do
      apply_library_file $f
    done
  )
}

find_with_maxdepth() {
  if [ x"$1" = x ]; then
    return 1
  fi
  if [ x"$2" = x ]; then
    return 2
  fi
  find "$1" -mindepth "$2" -maxdepth "$2"
}

copy_application_support_files() {
  for f in $(ls "Application Support"); do
    if [ ! -d "Application Support/$f" ]; then
      # echo "not found : Application Support/$f"
      continue
    fi
    case $f in
      CotEditor)
        find_with_maxdepth "Application Support/$f" 1
        ;;
      *)
        ;;
    esac
  done
}

application_support_files() {
  # find "Application Support" -depth 2
  for f in $(ls "Application Support"); do
    if [ ! -d "Application Support/$f" ]; then
      # echo "not found : Application Support/$f"
      continue
    fi
    case $f in
      CotEditor)
        # do nothing
        ;;
      Sublime\ Text\ 2)
        find_with_maxdepth "Application Support/$f" 2
        ;;
      *)
        find_with_maxdepth "Application Support/$f" 1
        ;;
    esac
  done

}

is_ignore_file() {
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

other_library_files() {
  for f in $(ls .); do
    if [ $f = "Application Support" -o -f $f ]; then
      # echo "skip"
      continue
    elif is_ignore_file $f; then
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

apply_library_file() {
  local HOME_LIB="$HOME/Library"
  local SRC=$1
  local TARGET=$HOME_LIB/$1

  if [ x$opt_uninstall = x1 ]; then
    [ -L "$TARGET" ] && trace rm "$TARGET"
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
        echo "skip mkdir : $SRC"
      else
        trace ln -s "$PWD/$SRC" "$TARGET"
      fi
    else
      echo "already linked : $SRC"
    fi
  fi

}

main() {
  local cwd=$(pwd)

  install_libraries

  cd $cwd
}

while getopts "hvud" opt; do
  case $opt in
    h)
      usage ;;
    u)
      opt_uninstall=1;;
    d)
      opt_dry_run=1;;
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

