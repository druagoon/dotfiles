ORBSTACK_ROOT="${HOME}/.orbstack"

__init_orbstack_path() {
    _dotf::cmd::path::prepend "${ORBSTACK_ROOT}/bin"
}

__init_orbstack() {
    __init_orbstack_path
}

__init_orbstack
