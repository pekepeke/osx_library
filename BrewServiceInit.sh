#!/bin/bash

is_executable() {
  which $1 >/dev/null 2>&1
  return $?
}

local brew_prefix=$(brew --prefix)

if is_executable mysql && [ ! -e $brew_prefix/var/mysql ]; then
  echo mysql_install_db
  mysql_install_db
fi

if is_executable boot2docker && [ ! -e ~/.boot2docker/boot2docker.iso ]; then
  boot2docker download
  boot2docker init
fi

if is_executable psql && [ ! -e $brew_prefix/var/postgres ]; then
  initdb $brew_prefix/var/postgres
fi
