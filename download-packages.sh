#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p packages
curl -fL --retry 3 -o packages/adspower.deb \
  https://version-v2.adspower.net/software/linux-x64-global/8.9.23/AdsPower-Global-8.9.23-x64.deb
curl -fL --retry 3 -o packages/hiddify.deb \
  https://github.com/hiddify/hiddify-app/releases/download/v5.5.5/Hiddify-Debian-x64.deb
printf '%s\n' \
  '34d494b5974e75a0eeec5b2e98135511f1d6cbccef0978ed9317d5d8a057dab9  packages/adspower.deb' \
  '2cd4b830a3db146a123fb3a69b02e7d6e6f5399c2b12236a5e3a639ba6b61492  packages/hiddify.deb' \
  | sha256sum --check -
# These vendor URLs track the current release; record each build's checksums.
curl -fL --retry 3 -o packages/chrome.deb \
  https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
curl -fL --retry 3 -o packages/telegram.tar.xz \
  https://telegram.org/dl/desktop/linux
sha256sum packages/* > build-packages.sha256
