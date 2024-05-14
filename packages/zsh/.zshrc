# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

unsetopt nomatch

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dragon"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
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

# Zsh components directory
ZSH_CUSTOM_UTILS="${ZSH_CUSTOM}/utils"
ZSH_CUSTOM_INITD="${ZSH_CUSTOM}/init.d"
ZSH_CUSTOM_SLOTS="${ZSH_CUSTOM}/slots"
ZSH_CUSTOM_PLUGINS="${ZSH_CUSTOM}/plugins"
ZSH_CUSTOM_COMPLETIONS="${ZSH_CUSTOM}/completions"

# Dotfiles root directory
DOTFILES_NAME="dotfiles"
DOTFILES_DOT_NAME=".dotfiles"
DOTFILES_ROOT="${HOME}/${DOTFILES_DOT_NAME}"

fpath+=(
    "${HOME}/.zcomp"
    "${HOME}/.zfunc"
)

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    colored-man-pages
    copypath
    cp
    docker
    golang
    git
    git-flow
    wd
)

# Load custom plugins if exists.
__zsh_load_custom_plugins() {
    local custom_plugins=(
        dragon-git-prompt
        zsh-autosuggestions
        zsh-syntax-highlighting
    )
    for plg in "${custom_plugins[@]}"; do
        if [[ -d "${ZSH_CUSTOM_PLUGINS}/${plg}" ]]; then
            plugins+=("${plg}")
        fi
    done
}

__zsh_init_bashcompinit() {
    autoload -U +X bashcompinit && bashcompinit
}

__zsh_init_env_paths() {
    local names=(sbin bin)
    local paths=(
        /usr/local
        "${HOME}/.local"
    )
    for v in "${paths[@]}"; do
        if [[ ! -d "${v}" ]]; then
            continue
        fi
        for b in "${names[@]}"; do
            local d="${v}/${b}"
            if [[ ! ":${PATH}:" == *":${d}:"* ]]; then
                export PATH="${d}:${PATH}"
            fi
        done
    done
}

__omz_pre_load() {
    __zsh_init_env_paths
    __zsh_init_bashcompinit
    __zsh_load_custom_plugins
}

__omz_pre_load

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
