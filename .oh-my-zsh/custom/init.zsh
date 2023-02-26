export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export ZSH_CUSTOM_ETC=$ZSH_CUSTOM/etc
export ZSH_CUSTOM_SLOTS=$ZSH_CUSTOM/slots
export ZSH_CUSTOM_COMPLETIONS=$ZSH_CUSTOM/completions

BASIC_SLOTS=(shell.sh proxy.sh conda.sh go.sh)

is_basic_slot() {
    ret="0"
    name=$(basename $f)
    for slot in "${BASIC_SLOTS[@]}"; do
        if [ "$slot" = "$1" ]; then
            ret="1"
            break
        fi
    done
    echo "$ret"
}

load_custom_slots() {
    for f in ${ZSH_CUSTOM_SLOTS}/*.sh; do
        name=$(basename $f)
        ret=$(is_basic_slot $name)
        if [ $ret = "0" ]; then
            # shellcheck disable=SC1090
            . "$f"
        fi
    done
}

load_basic_slots() {
    for slot in "${BASIC_SLOTS[@]}"; do
        # shellcheck disable=SC1090
        . "$ZSH_CUSTOM_SLOTS/$slot"
    done
}

init_slot() {
    load_basic_slots
    load_custom_slots
}

init_slot
