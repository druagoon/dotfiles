#!/usr/bin/env bash

set -e

include "lib/std/bool.sh"
include "lib/std/string.sh"
include "lib/std/os.sh"
include "lib/std/colors.sh"
include "lib/std/message.sh"

include "lib/local/consts.sh"

# Commands
include "commands/brewfile/cli.sh"
include "commands/brewfile/generate.sh"

include "commands/link.sh"

include "commands/layout/cli.sh"
include "commands/layout/export.sh"
include "commands/layout/sync.sh"

include "commands/package/cli.sh"
include "commands/package/new.sh"

include "commands/gitignore/cli.sh"
include "commands/gitignore/generate.sh"
