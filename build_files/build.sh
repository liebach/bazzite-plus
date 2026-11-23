#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y \
     abook \
     alacritty \
     alot \
     arc-kde \
     aspell \
     aspell-da \
     aspell-en \
     bat \
     calcurse \
     chezmoi \
     chicken \
     chicken-libs \
     chromium \
     desktop-backgrounds-kde \
     dictd \
     dictd-server \
     direnv \
     dnscrypt-proxy \
     duff \
     editorconfig \
     elisa-player \
     emacs \
     emacs-notmuch \
     fawltydeps+uv \
     fd-find \
     fedora-chromium-config-kde \
     firefox \
     flac \
     flac-devel \
     foot \
     foot-terminfo \
     francis \
     helix \
     helix-parsers \
     helix-themes \
     htop \
     iotop-c \
     isync \
     kalk \
     kitty \
     kitty-doc \
     kitty-kitten \
     kitty-shell-integration \
     kitty-terminfo \
     lame \
     lbdb \
     lftp \
     lftp-scripts \
     lowdown \
     lynx \
     materia-kde \
     mpv \
     multimarkdown \
     mupdf \
     mutt \
     netcat \
     nmap \
     powerdevil \
     ps_mem \
     qalculate \
     qalculate-qt \
     recode \
     restic \
     rlwrap \
     sbcl \
     senpai \
     signify \
     ssmtp \
     syncthing \
     syncthing-tools \
     tig \
     tree-sitter-cli \
     uv \
     vdirsyncer \
     vdirsyncer-doc \
     waynergy-kde \
     w3m \
     wlopm \
     zig \
     zig-doc \
     zig-libs \
     zoxide \
     zsh \
     zsh-autosuggestions \
     zsh-html \
     zsh-syntax-highlighting

dnf5 -y copr enable scottames/ghostty
dnf5 -y copr enable xc-34/ChiPass
dnf5 -y install ghostty ChiPass
# Disable COPRs so they don't end up enabled on the final image.
dnf5 -y copr disable scottames/ghostty
dnf5 -y copr disable xc-34/ChiPass

systemctl enable dictd
systemctl enable dnscrypt-proxy.service
systemctl enable podman.socket

# Set up system auth for the BitWarden app installed from flatpak.
# See: https://bitwarden.com/help/biometrics/#tab-linux-2vCWb5iFg4OqKS0B2xXpqW
# Works without the chcon(1) call, which fails during build. Lucky.
curl -o /usr/share/polkit-1/actions/com.bitwarden.Bitwarden.policy https://raw.githubusercontent.com/bitwarden/clients/main/apps/desktop/resources/com.bitwarden.desktop.policy
chown root:root /usr/share/polkit-1/actions/com.bitwarden.Bitwarden.policy
