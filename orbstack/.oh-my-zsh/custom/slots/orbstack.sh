ORBSTACK_ROOT="${HOME}/.orbstack"

__init_orbstack_path() {
    df_prepend_path "${ORBSTACK_ROOT}/bin"
}

__init_orbstack() {
    __init_orbstack_path
}

__init_orbstack
