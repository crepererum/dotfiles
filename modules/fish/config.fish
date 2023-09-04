# default editor
set -x EDITOR nvim

# podman instead of docker
set -x DOCKER_HOST "unix://$XDG_RUNTIME_DIR/podman/podman.sock"

# default key bindings (sometimes missing, for some reason)
set fish_key_bindings fish_default_key_bindings

# suppress the pointless welcome message
set fish_greeting ""

# extend PATH
set -gx PATH $HOME/scripts $HOME/go/bin $HOME/.cargo/bin $HOME/.krew/bin $HOME/.local/bin $PATH

# enable conda
set conda_exe $HOME/miniconda3/bin/conda
if test -e $conda_exe
    eval $conda_exe "shell.fish" "hook" $argv | source
end

# enable micromamda
set micromamba_exe /usr/bin/micromamba
if test -e $micromamba_exe
    eval $micromamba_exe shell hook --shell fish $argv | source
end

# colorful man pages
set -xU LESS_TERMCAP_mb (printf "\e[01;31m")      # begin blinking
set -xU LESS_TERMCAP_md (printf "\e[01;31m")      # begin bold
set -xU LESS_TERMCAP_me (printf "\e[0m")          # end mode
set -xU LESS_TERMCAP_se (printf "\e[0m")          # end standout-mode
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")   # begin standout-mode - info box
set -xU LESS_TERMCAP_ue (printf "\e[0m")          # end underline
set -xU LESS_TERMCAP_us (printf "\e[01;32m")      # begin underline

# go back alias
alias .- "cd -"
alias ... "cd ../.."
alias .... "cd ../../.."

alias testfonts "echo -e 'Normal, \x1b[1mbold\x1b[22m, \x1b[3mitalic\x1b[23m, \x1b[1;3mbold italic\x1b[22;23m'"

# short forms
alias nv nvim

# other cli aliases
alias https "http --default-scheme=https"

# clang++ quick test alias
function q++d
    clang++ -std=c++14 -g -Wall -Weverything -Wno-c++98-compat -Wno-c99-extensions -o (rootname $argv[1]) $argv
end
function q++o
    clang++ -std=c++14 -O2 -Wall -Weverything -Wno-c++98-compat -Wno-c99-extensions -o (rootname $argv[1]) $argv
end

# rootname (strip suffix)
function rootname
    echo $argv[1] | sed 's/\.[^.]*$//'
end

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    if test -e "$BASE16_SHELL"
        source "$BASE16_SHELL/profile_helper.fish"
        base16-bright

	# fix dark blue
	set -U fish_color_command normal
    end
end

# starship prompt
if type -q starship
    starship init fish | source
end

# kubectl
if type -q kubectl
    kubectl completion fish | source
end

# Poetry
set poetry_env "$HOME/.poetry/env"
if test -e "$poetry_env"
    source "$poetry_env"
end

# OPAM
set opam_script "$HOME/.opam/opam-init/init.fish"
if test -e "$opam_script"
    source "$opam_script"
end
