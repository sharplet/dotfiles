install_homebrew() {
  set -e

  iscmd brew && echo "Homebrew already installed." || (
    homebrew_url=https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

    echo "Installing Homebrew..."
    /bin/bash -c "$(/usr/bin/curl -fsSL "$homebrew_url")"
  )
}
