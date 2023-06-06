local path="${args[path]%/}"
local output="${args[--output]}"
local layout="${args[--layout]}"
local max_depth="${args["--max-depth"]}"
local dry_run="${args["--dry-run"]}"

if [[ -z "${output}" ]]; then
    if [[ -n "${layout}" ]]; then
        output="${DOTF_LAYOUT_DIR}/${layout}"
    else
        dotf::utils::message::fatal "missing --output or --layout, please see --help for detail."
    fi
fi

if ! dotf::utils::boolean::is_true "${dry_run}"; then
    local output_dir="$(dirname "${output}")"
    mkdir -p "${output_dir}"
    # Clear layout file content
    >"${output}"
fi

find "${path}" -maxdepth "${max_depth}" -name ".git" ! -path '*/.local/*' | sort | while read filename; do
    local filedir=$(dirname "${filename}")
    local url="$(git -C "${filedir}" config --get remote.origin.url)"
    local target="${filedir/#${HOME}/\~}"
    if dotf::utils::boolean::is_true "${dry_run}"; then
        dotf::utils::message::warning "[Simulate] ${target} ==> ${url}"
    else
        local line="${target};${url}\n"
        printf "${line}" >>"${output}"
    fi
done
