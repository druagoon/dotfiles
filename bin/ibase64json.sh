#!/bin/bash

### Base64/JSON 解码 ###

pbpaste|base64 -D|jq --indent 4 -S .|pbcopy && echo 'ok'
