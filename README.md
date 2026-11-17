# Ubuntu — four apps

Kasm Ubuntu 24.04 core + Telegram, Google Chrome, AdsPower, Hiddify.
Desktop, terminal, file manager and required system/runtime libraries are retained.
No credentials, subscriptions or proxy nodes are embedded.
No TUN device, privileged mode or NET_ADMIN capability is required.

Build:

```sh
bash download-packages.sh
docker build -t local/ubuntu-four-apps:1.19.0 .
```

Installation packages are downloaded from the official vendor websites.
See `packages.sha256` for their checksums.
This file records the original local downloads. Chrome and Telegram URLs
track the latest version, so new downloads can differ. Each CI build saves
its actual checksums as the `package-checksums` artifact.

## GitHub Actions / GHCR

Pushes to `main`, `v*` tags, and manual workflow runs build an amd64 image
and publish it to `ghcr.io/ymingdev/ubuntu-four-apps`.
Pull requests only build; they do not publish.
Main publishes `latest`, `1.19.0`, and a commit-specific tag.

```sh
docker pull ghcr.io/ymingdev/ubuntu-four-apps:1.19.0
```

The workflow uses the built-in `GITHUB_TOKEN`; no SSH key or registry
password needs to be added to Actions secrets. Allow Actions to write
packages in repository/organization settings if restricted.
GHCR packages can initially be private even when the source repository
is public. After first publication, set package visibility to **Public**
in GitHub package settings if anonymous pulls are desired.
Check vendor redistribution terms before making the image public.

Hiddify: preinstalled only; TUN mode is not configured.
AdsPower may require an account and download its browser engines on first use.
