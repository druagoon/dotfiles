# @cmd Create a new dotfiles package
# @arg name!
package::new() {
    local pkg_dir="${DOTF_PKG_ROOT}/${argc_name}"
    local pkg_omz_custom_dir="${pkg_dir}/.oh-my-zsh/custom"
    mkdir -p "${pkg_dir}"/{.zfunc,.zcomp}
    mkdir -p "${pkg_omz_custom_dir}"/{completions,slots}
}
