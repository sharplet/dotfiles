#!/bin/sh

set -e

source ./profile

iscmd port && echo "MacPorts already installed." || (
  echo "Installing MacPorts..."

  tmpdir="$(mktemp -d /tmp/rcup-install-macports.XXXXXX)"
  trap "rm -rf $tmpdir" EXIT
  cd "$tmpdir"

  macports_version="$(
    curl -s --head https://github.com/macports/macports-base/releases/latest \
      | sed -En 's|^Location:[[:space:]]+https://.*github\.com/.+/tag/v?([^[:space:]/]+).*$|\1|ip'
  )"
  archive_base="MacPorts-$macports_version"
  tarball="$archive_base.tar.gz"

  curl -O "https://distfiles.macports.org/MacPorts/$tarball"
  tar xzf "$tarball"
  cd "$archive_base"

  ./configure
  make
  sudo make install
)

echo "Installing rcm..."
sudo port install rcm

echo "Running rcup..."
env RCRC=./rcrc rcup
