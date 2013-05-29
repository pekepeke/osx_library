#!/bin/bash

usage() {
  prg_name=`basename $0`
  cat <<EOM
  Usage: $prg_name [-h]
EOM
  exit 1
}
has_app() {
  [ -e /Applications/$1.app ] && return 0
  return 1
}

main() {
  if has_app SecondBar ; then
    test $(system_profiler SPDisplaysDataType | grep Online | wc -l) -gt 1 && open -a SecondBar
  fi
}

OPTIND_OLD=$OPTIND
OPTIND=1
while getopts "h" opt; do
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

