dotf::utils::boolean::is_true() {
    case "$1" in
        true | yes | 1 | "1")
            true
            return
            ;;
        *)
            false
            return
            ;;
    esac
}

dotf::utils::boolean::is_false() {
    case "$1" in
        false | no | 0 | "0")
            true
            return
            ;;
        *)
            false
            return
            ;;
    esac
}
