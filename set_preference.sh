#!/bin/bash

opt_apply=0
APPLICATIONS="KeyRemap4MacBook GeekTool Spectacle"
usage() {
  prg_name=`basename $0`
  cat <<EOM
  Usage: $prg_name [-h]
EOM
  exit 1
}

preferences() {
  find "Preferences" -type f
}

ctl_applications() {
  local cmd="killall"
  local opt=""
  if [ x$1 != xstop ]; then
    cmd=open
    opt="-a"
  fi
  for app in $APPLICATIONS; do
    ${cmd} ${opt} ${app}
  done
}

yes_or_no() {
  local ret
  if [ "x$1" != x ]; then
    echo $1
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
  cd $(dirname $0)
  local tm=$(date +'%S')
  ctl_applications stop
  for f in $(preferences); do
    local TARGET="$HOME/Library/$f"
    if [ x$opt_apply = 1 ]; then
      if yes_or_no "copy $f -> $TARGET" ; then
        cp -irp $TARGET /tmp/$(basename $TARGET).library
        [ ! -e $TARGET.org -a ! -L $TARGET ] && mv $TARGET $TARGET.org
        trace cp $f $TARGET
      fi
    else
      if yes_or_no "copy $TARGET -> $f" ; then
        cp -irp $f /tmp/$(basename $f).github
        trace cp $TARGET $f
      fi
    fi
  done
  ctl_applications start
}

while getopts "hvs:" opt; do
  case $opt in
    h)
      usage ;;
    a) opt_apply=1;;
    s)
      #$OPTARG
      ;;
  esac
done
shift `expr $OPTIND - 1`
if [ $OPT_ERROR ]; then
  usage
fi

main "$@"

