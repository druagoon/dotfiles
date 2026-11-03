alias bi="brew info"
alias bci="brew info --cask"
alias bs="brew search"
alias bcs="brew search --cask"
alias bii="brew install"
alias bcii="brew install --cask"
alias buv="brew update -v"
alias blf="brew list --full-name"
alias bclf="brew list --cask --full-name"
alias blff="brew list --formula --full-name"
alias bog="brew outdated --greedy"
alias bcog="brew outdated --cask --greedy"
alias bug="brew upgrade --greedy"
alias bcug="brew upgrade --cask --greedy"

# export HOMEBREW_NO_ANALYTICS="1"

# Homebrew network settings
export HOMEBREW_DOWNLOAD_CONCURRENCY=4
export HOMEBREW_CURL_RETRIES=3

# Keep the default daily metadata refresh
export HOMEBREW_AUTO_UPDATE_SECS=86400

# Remove older download cache during cleanup
export HOMEBREW_CLEANUP_MAX_AGE_DAYS=30
