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
     lbdb \
     lowdown \
     mutt \
     netcat \
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
     zoxide

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

systemctl enable dictd
systemctl enable dnscrypt-proxy.service
systemctl enable podman.socket
