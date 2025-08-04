### User Configuration ###
# Avoid errors with non-existing files
unsetopt nomatch

# Dotfiles root directory
export DOTFILES_ROOT="${HOME}/.dotfiles"

# Locale && Language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor
export EDITOR="vim"

# Functions
# Add paths to the PATH environment variable if they are not already included
add_env_paths() {
    for p in "$@"; do
        if [[ ! ":${PATH}:" == *":${p}:"* ]]; then
            export PATH="${p}:${PATH}"
        fi
    done
}

### Oh My Zsh Configuration ###
# Disable automatic updates
zstyle ':omz:update' mode disabled

# Disable magic functions
DISABLE_MAGIC_FUNCTIONS="true"

# Name of the theme to load
ZSH_THEME="dotf"

# Zsh custom directory
ZSH_CUSTOM="${ZSH}/custom"

# Zsh custom components directory
ZSH_CUSTOM_PLUGINS="${ZSH_CUSTOM}/plugins"
ZSH_CUSTOM_FUNCTIONS="${ZSH_CUSTOM}/functions"
ZSH_CUSTOM_COMPLETIONS="${ZSH_CUSTOM}/completions"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    brew
    colored-man-pages
    copypath
    cp
    direnv
    docker
    git
    git-flow
    git-prompt
    wd
)

omz_pre_is_plugin() {
    local name="${1}"
    [[ -f "${ZSH_CUSTOM_PLUGINS}/${name}/${name}.plugin.zsh" ]]
}

omz_pre_load_plugin_consts() {
    local name="${1}"
    local file="${ZSH_CUSTOM_PLUGINS}/${name}/consts.zsh"
    [[ -f "${file}" ]] && source "${file}"
}

# Load custom plugins if exists.
omz_pre_load_plugins() {
    # Required dotf plugins
    local required_plugins=(
        dotf-core
        dotf-shell
        dotf-shell-proxy
        dotf-go
        dotf-rust
        dotf-python-venv
    )
    for name in "${required_plugins[@]}"; do
        if omz_pre_is_plugin "${name}" ]]; then
            plugins+=("${name}")
        fi
        omz_pre_load_plugin_consts "${name}"
    done

    # Collect other dotf plugins
    local name ignore
    for plg in "${ZSH_CUSTOM_PLUGINS}"/dotf-*(N); do
        if [[ -d "${plg}" ]]; then
            name="${plg##*/}"
            ignore="${plg}/.dotfignore"
            if [[ ! " ${required_plugins[*]} " == *" ${name} "* ]] && [[ ! -f "${ignore}" ]]; then
                if omz_pre_is_plugin "${name}" ]]; then
                    plugins+=("${name}")
                fi
                omz_pre_load_plugin_consts "${name}"
            fi
        fi
    done

    # Third-party plugins
    plugins+=(
        zsh-autosuggestions
        zsh-syntax-highlighting
    )
}

omz_pre_load_bashcompinit() {
    autoload -U +X bashcompinit && bashcompinit
}

omz_pre_add_sys_env_paths() {
    local paths=(
        /usr/local/sbin
        /usr/local/bin
    )
    add_env_paths "${paths[@]}"
}

omz_pre_load() {
    omz_pre_add_sys_env_paths
    omz_pre_load_bashcompinit
    omz_pre_load_plugins
}

omz_pre_load

# unfunction ${(k)functions[(I)omz_pre_*]}
