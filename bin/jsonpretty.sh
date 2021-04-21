#!/bin/bash

### JSON格式化 ###

pbpaste|jq --indent 4 -S .|pbcopy && echo 'ok'
