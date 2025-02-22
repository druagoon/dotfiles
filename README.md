<!-- markdownlint-disable MD033 MD036 -->
<h1>dotfiles</h1>

This repository contains configuration files and scripts to set up and manage my
development environment efficiently. It includes tools and settings for various
applications and utilities to streamline your workflow.

**Table of Contents**

- [Prerequisites](#prerequisites)
  - [Enpass (Optional)](#enpass-optional)
  - [Clash](#clash)
  - [iTerm2 (Optional)](#iterm2-optional)
- [Installation](#installation)
- [Initialization](#initialization)
  - [Link Packages](#link-packages)

## Prerequisites

### [Enpass](https://www.enpass.io/) (Optional)

> Password and credentials mananger

### [Clash](https://github.com/Dreamacro/clash)

> Rule-based custom proxy with GUI based on clash

- [Clash Verge](https://github.com/clash-verge-rev/clash-verge-rev)
- [ClashX Pro](https://install.appcenter.ms/users/clashx/apps/clashx-pro/distribution_groups/public)
- [ClashX](https://github.com/yichengchen/clashX)

### [iTerm2](https://iterm2.com/) (Optional)

> Terminal emulator as alternative to Apple's Terminal app

## Installation

Clone the repository and run the installation script:

```shell
git clone git@github.com:druagoon/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## Initialization

### Link Packages

Link the configuration packages to their respective locations:

```shell
dotf link -- -v
```

This setup ensures that your development environment is consistent and easily reproducible across different machines.
