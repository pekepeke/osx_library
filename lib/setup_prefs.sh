#!/bin/bash

opt_apply=0
APPLICATIONS=$(cat <<EOM
KeyRemap4MacBook
GeekTool Helper
Spectacle
EOM
)

usage() {
  prg_name=`basename $0`
  cat <<EOM
  Usage: $prg_name [-h]

-h : help
-a : apply
EOM
  exit 1
}

preferences() {
  echo "Application Support/BetterTouchTool/bttdata2"
  find "Preferences" -type f
}

ctl_applications() {
  local cmd="killall"
  local opt=""
  if [ x$1 != xstop ]; then
    cmd=open
    opt="-a"
  fi
  (
    IFS=$'\n';
    for app in $APPLICATIONS; do
      echo ${cmd} ${opt} ${app}
      ${cmd} ${opt} ${app}
    done
  )
}

yes_or_no() {
  local ret
  if [ "x$1" != x ]; then
    echo -e $1
  fi
  echo -n "OK? [y/n] : "
  read ret
  [ "x$ret" = "xy" ]
  return $?
}

trace() {
  echo $*
  $*
}

main() {
  local base_dir=$($(dirname $0)/..; pwd)
  cd $base_dir/Library
  local tm=$(date +'%S')

  local RED="\033[1;31m"
  local GREEN="\033[1;32m"
  local YELLOW="\033[1;33m"
  local BLUE="\033[1;34m"
  local GRAY="\033[1;37m"
  local DEFAULT="\033[00m"

  if [ x$opt_apply = x1 ]; then
    echo -e "${RED}#### Repos -> HOME${DEFAULT}"
    ctl_applications stop
  else
    echo -e "${BLUE}#### HOME -> Repos${DEFAULT}"
  fi
  (
    IFS=$'\n';
    for f in $(preferences); do
      local TARGET="$HOME/Library/$f"
      if diff $TARGET $f > /dev/null; then
        continue
      fi
      if [ ${f##*.} = "plist" -a -e $f -a -e $TARGET ]; then
        $base_dir/tools/bin/pldiff.pl $TARGET $f
      fi
      local label_f=$([ $f -nt $TARGET ] && echo "(new)")
      local label_t=$([ $TARGET -nt $f ] && echo "(new)")
      if [ x$opt_apply = x1 ]; then

        if yes_or_no "copy ${YELLOW}$f${label_f}${DEFAULT} -> ${RED}$TARGET${label_t}${DEFAULT}" ; then
          cp -irp $TARGET /tmp/$(basename $TARGET).library
          [ ! -e $TARGET.org -a ! -L $TARGET ] && mv $TARGET $TARGET.org
          trace cp "$f" "$TARGET"
        fi
      else
        if yes_or_no "copy ${RED}$TARGET${label_t}${DEFAULT} -> ${YELLOW}$f${label_f}${DEFAULT}" ; then
          cp -irp $f /tmp/$(basename $f).github
          trace cp "$TARGET" "$f"
        fi
      fi
    done
  )
  if [ x$opt_apply = x1 ]; then
    ctl_applications start
  fi
}

while getopts "ha" opt; do
  case $opt in
    h)
      usage ;;
    a) opt_apply=1;;
    #s)
    #  $OPTARG
    #  ;;
  esac
done
shift `expr $OPTIND - 1`
if [ $OPT_ERROR ]; then
  usage
fi

main "$@"

