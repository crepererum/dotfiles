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

# extend PATH
set -gx PATH $HOME/scripts $HOME/.cargo/bin $PATH

# colorful man pages
set -xU LESS_TERMCAP_mb (printf "\e[01;31m")      # begin blinking
set -xU LESS_TERMCAP_md (printf "\e[01;31m")      # begin bold
set -xU LESS_TERMCAP_me (printf "\e[0m")          # end mode
set -xU LESS_TERMCAP_se (printf "\e[0m")          # end standout-mode
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")   # begin standout-mode - info box
set -xU LESS_TERMCAP_ue (printf "\e[0m")          # end underline
set -xU LESS_TERMCAP_us (printf "\e[01;32m")      # begin underline

# go back alias
alias - "cd -"

# clang++ quick test alias
function q++d
    clang++ -std=c++14 -g -Wall -Weverything -Wno-c++98-compat -o (rootname $argv[1]) $argv
end
function q++o
    clang++ -std=c++14 -O2 -Wall -Weverything -Wno-c++98-compat -o (rootname $argv[1]) $argv
end
