#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
POWERLINE_PACKAGE_DIR="$( pip show powerline-status 2>/dev/null | grep Location | awk '{print $2}')"

main() {
	tmux run-shell "powerline-daemon -q"
	tmux source "$POWERLINE_PACKAGE_DIR/powerline/bindings/tmux/powerline.conf"
}
main
