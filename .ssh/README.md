# SSH

## Setup

- Change `.ssh` directory perm

    ```sh
    chmod 700 ~/.ssh
    ```

- Change `config` | `id_rsa` | `hosts` perm

    ```sh
    chmod 600 ~/.ssh/{config,id_rsa} \
    && chmod 700 ~/.ssh/hosts \
    && chmod 600 ~/.ssh/hosts/*
    ```
