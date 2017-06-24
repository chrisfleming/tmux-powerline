#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
POWERLINE_PACKAGE_DIR="$( pip show powerline-status 2>/dev/null | grep Location | awk '{print $2}')"

runpowerline() {
	tmux run-shell "powerline-daemon -q"
	tmux source "$POWERLINE_PACKAGE_DIR/powerline/bindings/tmux/powerline.conf"
}

nopowerline() {
     tmux set-option set -g status "on"
    tmux set-option -g status-interval 2
    tmux set-option -g status-left-length 20
    tmux set-option -g status-right-length "150"

     tmux set-option -g status-bg colour233
    tmux set-option -g status-fg colour231
     tmux set-option -g status-justify left

     tmux set-option -g status-left "#{?client_prefix,#[fg=colour254]#[bg=colour31]#[bold]#[noitalics]#[nounderscore],#[fg=colour16]#[bg=colour254]#[bold]#[noitalics]#[nounderscore]} #S #{?client_prefix,#[fg=colour31],#[fg=colour254]}#[bg=colour233]#[nobold] #(env $POWERLINE_COMMAND $POWERLINE_COMMAND_ARGS tmux left)"
     tmux set-option -g status-right "#[fg=colour233,bg=default,nobold,noitalics,nounderscore] #[fg=colour247,bg=colour233,nobold,noitalics,nounderscore] #(uptime | awk '{print $3}')d#[fg=colour241,bg=colour233,nobold,noitalics,nounderscore] #[fg=colour2,bg=colour233,nobold,noitalics,nounderscore]#(uptime | rev | cut -d":" -f1 | rev | sed s/,//g)#[fg=colour236,bg=colour233,nobold,noitalics,nounderscore] #[fg=colour247,bg=colour236,nobold,noitalics,nounderscore] #(date +"%Y-%m-%d")#[fg=colour241,bg=colour236,nobold,noitalics,nounderscore] #[fg=colour252,bg=colour236,bold,noitalics,nounderscore] "%H:%M:%S"#[fg=colour252,bg=colour236,nobold,noitalics,nounderscore] #[fg=colour16,bg=colour252,bold,noitalics,nounderscore]  #(hostname)"
     tmux set-option -g window-status-current-format "#[fg=colour233,bg=colour31,nobold,noitalics,nounderscore] #[fg=colour117,bg=colour31,nobold,noitalics,nounderscore]#I  #[fg=colour231,bg=colour31,bold,noitalics,nounderscore]#W #[fg=colour31,bg=colour233,nobold,noitalics,nounderscore] "
     tmux set-option -g window-status-fg colour249
     tmux set-option -g window-status-format "#[fg=colour244,bg=colour233,nobold,noitalics,nounderscore]  #I #[fg=colour240,bg=colour233,nobold,noitalics,nounderscore] #[default]#W   "
     tmux set-option -g window-status-last-attr none
     tmux set-option -g window-status-last-bg colour233
     tmux set-option -g window-status-last-fg colour31
     tmux set-option -g window-status-last-style fg=colour31,bg=colour233
     tmux set-option -g window-status-style fg=colour249,bg=colour233
     tmux set-option -g window-status-separator ""
}


main() {
	# if we have powerline then use that, otherwise use fixed status.
	if  [ -x "$(command -v powerline-daemon)" ]; then
		runpowerline
	else
		nopowerline
	fi
}
main
