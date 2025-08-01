# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

unsetopt nomatch

# Locale && Language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor
export EDITOR="vim"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dotf"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="${ZSH}/custom"

# Zsh custom components directory
ZSH_CUSTOM_PLUGINS="${ZSH_CUSTOM}/plugins"
ZSH_CUSTOM_FUNCTIONS="${ZSH_CUSTOM}/functions"
ZSH_CUSTOM_COMPLETIONS="${ZSH_CUSTOM}/completions"

# Dotfiles root directory
export DOTFILES_ROOT="${HOME}/.dotfiles"

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

__is_dotf_plugin() {
    local name="${1}"
    [[ -f "${ZSH_CUSTOM_PLUGINS}/${name}/${name}.plugin.zsh" ]]
}

__load_dotf_consts() {
    local name="${1}"
    local file="${ZSH_CUSTOM_PLUGINS}/${name}/consts.zsh"
    [[ -f "${file}" ]] && source "${file}"
}

# Load custom plugins if exists.
__zsh_load_custom_plugins() {
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
        if __is_dotf_plugin "${name}" ]]; then
            plugins+=("${name}")
        fi
        __load_dotf_consts "${name}"
    done

    # Collect other dotf plugins
    local name ignore
    for plg in "${ZSH_CUSTOM_PLUGINS}"/dotf-*(N); do
        if [[ -d "${plg}" ]]; then
            name="${plg##*/}"
            ignore="${plg}/.dotfignore"
            if [[ ! " ${required_plugins[*]} " == *" ${name} "* ]] && [[ ! -f "${ignore}" ]]; then
                if __is_dotf_plugin "${name}" ]]; then
                    plugins+=("${name}")
                fi
                __load_dotf_consts "${name}"
            fi
        fi
    done

    # Third-party plugins
    plugins+=(
        zsh-autosuggestions
        zsh-syntax-highlighting
    )
}

__zsh_init_bashcompinit() {
    autoload -U +X bashcompinit && bashcompinit
}

__zsh_init_env_paths() {
    for p in "$@"; do
        if [[ ! ":${PATH}:" == *":${p}:"* ]]; then
            export PATH="${p}:${PATH}"
        fi
    done
}

__zsh_init_sys_env_paths() {
    local paths=(
        /usr/local/sbin
        /usr/local/bin
    )
    __zsh_init_env_paths "${paths[@]}"
}

__zsh_init_user_env_paths() {
    local paths=(
        "${HOME}/.local/bin"
    )
    __zsh_init_env_paths "${paths[@]}"
}

__omz_pre_load() {
    __zsh_init_sys_env_paths
    __zsh_init_bashcompinit
    __zsh_load_custom_plugins
}

__omz_post_load() {
    __zsh_init_user_env_paths
}

__omz_pre_load

# unfunction ${(k)functions[(I)__zsh_init_*]}

source $ZSH/oh-my-zsh.sh

__omz_post_load

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
