#!/bin/sh

set -e

list_swift_executables() {
  swift package describe --type json \
    | jq --raw-output '.targets | map(select(.type == "executable")) | .[].name'
}

swift build -c release
list_swift_executables | xargs -I{} ln -sf ../.build/release/{} scripts/{}
