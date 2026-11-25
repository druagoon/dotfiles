# Pull container images via official skopeo container instead of Docker Daemon networking.
dpull() {
    if (($# < 1)) || [[ "$1" == "-h" || "$1" == "--help" ]]; then
        printf 'Usage: dpull [SKOPEO_COPY_OPTIONS...] IMAGE[:TAG][@DIGEST]\n' >&2
        return 2
    fi

    # Prefer lowercase proxy variables over uppercase; fall back to all_proxy/ALL_PROXY.
    local all_p="${all_proxy:-${ALL_PROXY:-}}"
    local http_p="${http_proxy:-${HTTP_PROXY:-$all_p}}"
    local https_p="${https_proxy:-${HTTPS_PROXY:-$all_p}}"
    local no_p="${no_proxy:-${NO_PROXY:-}}"

    if [[ -z "$http_p" && -z "$https_p" ]]; then
        printf 'Error: No proxy detected. Set https_proxy, http_proxy, or all_proxy first.\n' >&2
        return 1
    fi

    local -a extra_args=()
    while (($# > 1)); do
        extra_args+=("$1")
        shift
    done

    local image="$1"
    if [[ -z "$image" || "$image" == *"://"* || "$image" == *[[:space:]]* ||
        "$image" == /* || "$image" == */ ]]; then
        printf 'Invalid image reference: %s\n' "$image" >&2
        return 2
    fi

    local repo_tag="$image"
    local digest=""
    if [[ "$image" == *@* ]]; then
        repo_tag="${image%%@*}"
        digest="${image#*@}"
        if [[ -z "$repo_tag" || -z "$digest" ]]; then
            printf 'Invalid digest reference: %s\n' "$image" >&2
            return 2
        fi
    fi

    local last_component="${repo_tag##*/}"
    local repo="$repo_tag"
    local tag=""
    if [[ "$last_component" == *:* ]]; then
        repo="${repo_tag%:*}"
        tag="${repo_tag##*:}"
        if [[ -z "$tag" ]]; then
            printf 'Empty tag in image reference: %s\n' "$image" >&2
            return 2
        fi
    elif [[ -n "$digest" ]]; then
        printf 'Digest-only pulls require a local tag for docker-daemon (e.g. %s:TAG@%s)\n' \
            "$repo_tag" "$digest" >&2
        return 2
    else
        tag="latest"
    fi

    # Canonicalize Docker Hub short names.
    local first_component="${repo%%/*}"
    if [[ "$repo" != */* ]]; then
        repo="docker.io/library/${repo}"
    elif [[ "$first_component" != *.* &&
        "$first_component" != *:* &&
        "$first_component" != "localhost" ]]; then
        repo="docker.io/${repo}"
    fi

    local src_ref dest_ref
    dest_ref="${repo}:${tag}"
    if [[ -n "$digest" ]]; then
        src_ref="${repo}@${digest}"
    else
        src_ref="$dest_ref"
    fi

    local -a docker_env=()
    [[ -n "$http_p" ]] && docker_env+=(-e "HTTP_PROXY=$http_p")
    [[ -n "$https_p" ]] && docker_env+=(-e "HTTPS_PROXY=$https_p")
    [[ -n "$no_p" ]] && docker_env+=(-e "NO_PROXY=$no_p")

    printf 'Pulling: %s -> %s\n' "$src_ref" "$dest_ref"

    docker run --rm --network host \
        -v /var/run/docker.sock:/var/run/docker.sock \
        "${docker_env[@]}" \
        quay.io/skopeo/stable:latest copy \
        "${extra_args[@]}" \
        "docker://${src_ref}" \
        "docker-daemon:${dest_ref}"
}
