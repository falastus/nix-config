# Lines configured by zsh-newuser-install
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/falastus/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export PGDATA="$HOME/postgre_data"
export PGHOST="/tmp"
export PGPORT="5432"

export DOCKER_HOST=unix:///${XDG_RUNTIME_DIR}/podman/podman.sock
export TESTCONTAINERS_RYUK_DISABLED=true

eval "$(starship init zsh)"
