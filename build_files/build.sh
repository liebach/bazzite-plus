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
     calcurse \
     chicken \
     chicken-libs \
     desktop-backgrounds-kde \
     dictd \
     dictd-server \
     direnv \
     dnscrypt-proxy \
     duff \
     editorconfig \
     emacs \
     emacs-notmuch \
     fedora-chromium-config-kde \
	 firefox \
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
     lbdb \
     lftp \
     lftp-scripts \
     lowdown \
     lynx \
     materia-kde \
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
