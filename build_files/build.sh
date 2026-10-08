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
     alot \
     aspell \
     aspell-da \
     aspell-en \
     calcurse \
     dictd \
     dictd-server \
     direnv \
     dnscrypt-proxy \
     editorconfig \
     emacs \
     emacs-notmuch \
     foot \
     foot-terminfo \
     fzf \
     htop \
     iotop-c \
     isync \
     kitty \
     kitty-bash-integration \
     kitty-doc \
     kitty-kitten \
     kitty-shell-integration \
     kitty-terminfo \
     labwc \
     labwc-menu-generator \
     labwc-session \
     labwc-tweaks \
     lbdb \
     lowdown \
     mutt \
     netcat \
     noctalia \
     nmap \
     ps_mem \
     ssmtp \
     syncthing \
     syncthing-tools \
     tig \
     tree-sitter-cli \
     vdirsyncer \
     vdirsyncer-doc \
     w3m \
     zig \
     zig-doc \
     zig-libs \
     zoxide

dnf5 -y copr enable scottames/ghostty
dnf5 -y install ghostty
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable scottames/ghostty

systemctl enable dictd
systemctl enable dnscrypt-proxy.service
systemctl enable podman.socket
