<!-- markdownlint-disable MD033 MD036 -->
<h1>dotfiles</h1>

My dotfiles for configuring the development environment, managed by [rotz](https://github.com/volllly/rotz).

**Table of Contents**

- [Prerequisites](#prerequisites)
  - [Enpass (Optional)](#enpass-optional)
  - [Clash](#clash)
  - [iTerm2 (Optional)](#iterm2-optional)
- [Installation](#installation)
- [Initialization](#initialization)

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
curl -fsSL https://raw.githubusercontent.com/druagoon/dotfiles/master/install.sh | bash
```

## Initialization

Link the configurations to their respective locations using `rotz`:

```shell
rotz link
```

This setup ensures that your development environment is consistent and easily reproducible across different machines.
