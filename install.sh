#!/bin/sh

set -e

install=help
tags=

for opt; do
  case $opt in
    --homebrew)
      install=homebrew
      touch .install-homebrew
      cleanup="rm -f .install-homebrew"
      shift
      ;;
    --macports)
      install=macports
      touch .install-macports
      cleanup="rm -f .install-macports"
      shift
      ;;
    *)
      break
      ;;
  esac
done

[ -n "$cleanup" ] && trap "$cleanup" EXIT

case $install in
  help)
    echo "Usage:"
    echo "    ./install.sh --homebrew                 Install with Homebrew"
    echo "    ./install.sh --macports                 Install with MacPorts"
    exit
    ;;
  homebrew)
    source profile
    source install/homebrew.sh
    install_homebrew
    iscmd rcup || (echo "Installing rcm..."; brew install rcm)
    ;;
  macports)
    source profile
    source install/macports.sh
    install_macports
    tags="-t macports"
    iscmd rcup || (echo "Installing rcm..."; sudo port install rcm)
    ;;
esac

echo "Running rcup..."
env RCRC=./rcrc rcup $tags

echo "rcup complete. You may wish to start a new shell."
