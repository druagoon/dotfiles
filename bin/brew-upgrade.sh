#!/bin/bash

brew outdated --verbose|grep -v _|grep -v pinned|awk -F '(' '{print $1}'|awk '{print $1}'|xargs -I{} brew upgrade {}
