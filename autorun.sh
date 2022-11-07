#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run "pipewire"
run "pipewire-pulse"

exec picom --experimental-backends &
exec /usr/bin/emacs -daemon
