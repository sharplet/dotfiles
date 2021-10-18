internal_homebrew_url="https://$GITHUB_INTERNAL/raw/gist/sharplet/4d2596f12746cd6e72c156d199b7df7d/raw/6eb4e6662d86a2a341838f4e13224bc01afe4675/install_homebrew.sh"

if ! iscmd brew \
  && install_homebrew_tmp="$(mktemp -d /tmp/install_homebrew.XXXXXX)" \
  && /usr/bin/curl -fsSL -o "$install_homebrew_tmp/install_homebrew.sh" "$internal_homebrew_url"
then
  source "$install_homebrew_tmp/install_homebrew.sh"
  rm -rf "$install_homebrew_tmp"
  unset install_homebrew_tmp
else
  install_homebrew() {
    iscmd brew && return

    [ -n "$ZSH_VERSION" ] && read -q "install_public?Install public Homebrew?" \
      || read -p "Install public Homebrew?" install_public

    case "$install_public" in
      [Yy]*)
        /bin/bash -c "$(/usr/bin/curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh")"
        ;;
      *)
        echo >&2 "fatal: Unable to install Homebrew"
        return 1
        ;;
    esac
  }
fi

unset internal_homebrew_url
