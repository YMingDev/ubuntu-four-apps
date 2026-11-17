#!/usr/bin/env bash
set -euo pipefail
profile=/home/kasm-default-profile
mkdir -p "$profile/Desktop" "$profile/.local/share/applications"
# Remove base-image desktop shortcuts, not the desktop/system components.
find "$profile/Desktop" -maxdepth 1 -name '*.desktop' -delete
cat > /usr/share/applications/telegram-custom.desktop <<'EOF'
[Desktop Entry]
Type=Application
Name=Telegram
Exec=/opt/telegram/Telegram -- %u
Icon=telegram
Terminal=false
Categories=Network;
EOF
# Use vendor launchers so executable paths and bundled icons remain correct.
python3 - <<'PY'
import pathlib, shutil
root=pathlib.Path('/usr/share/applications')
dest=pathlib.Path('/home/kasm-default-profile/Desktop')
for label, needle in [('Telegram','telegram-custom'),('Chrome','google-chrome'),('AdsPower','adspower'),('Hiddify','hiddify')]:
    matches=[p for p in root.glob('*.desktop') if needle.lower() in p.name.lower()]
    if not matches:
        matches=[p for p in root.glob('*.desktop') if needle.lower() in p.read_text(errors='replace').lower()]
    if not matches:
        raise RuntimeError(f'No vendor launcher found for {label}')
    source=matches[0]
    target=dest/(label+'.desktop')
    shutil.copyfile(source,target)
    target.chmod(0o755)
PY
