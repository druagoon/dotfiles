local source="${args[--source]}"
local layout="${args[--layout]}"
local dry_run="${args["--dry-run"]}"

if [[ -z "${source}" ]]; then
    if [[ -n "${layout}" ]]; then
        source="${DOTF_LAYOUT_DIR}/${layout}"
    else
        dotf::utils::message::fatal "missing --source or --layout, please see --help for detail."
    fi
fi
if [[ ! -f "${source}" ]]; then
    dotf::utils::message::fatal "'%s' not exists." "${source}"
fi

while read line; do
    set -f # avoid globbing (expansion of *).
    local parts=(${line/;/ })
    local path="${parts[0]/#\~/${HOME}}"
    local url="${parts[1]}"
    if [[ ! -d "${path}" ]]; then
        local msg="git clone '${url}' to '${path}'"
        if dotf::utils::boolean::is_true "${dry_run}"; then
            dotf::utils::message::warning "[Simulate] ${msg}"
        else
            echo "${msg}"
            git clone "${url}" "${path}" && echo
        fi
    fi
done <${source}
