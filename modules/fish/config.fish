# proper terminal variables
# this is especially required on gnome terminal
switch $TERM
    case xterm
        set -x TERM xterm-256color
        set -x COLORTERM xterm-256color
    case screen
        set -x TERM screen-256color
        set -x COLORTERM screen-256color
end

# default editor
set -x EDITOR nvim

# suppress the pointless welcome message
set fish_greeting ""
