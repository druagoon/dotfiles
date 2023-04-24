__ruby_root="$(brew --prefix ruby)"
__ruby_bin="${__ruby_root}/bin"
__ruby_self="${__ruby_bin}/ruby"
__ruby_gem="${__ruby_bin}/gem"
__ruby_bundle="${__ruby_bin}/bundle"

alias rruby="${__ruby_self}"
alias rgem="${__ruby_gem}"
alias rbundle="${__ruby_bundle}"

__init_ruby_env() {
    local user_gemhome="$("${__ruby_gem}" environment user_gemhome 2>/dev/null)"
    if [[ -n "${user_gemhome}" ]]; then
        df::cmd::path::prepend "${user_gemhome}/bin"
    fi
}

__init_ruby() {
    __init_ruby_env
}

__init_ruby
