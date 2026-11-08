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
     aspell \
     aspell-da \
     aspell-en \
     calcurse \
     chicken \
     chicken-libs \
     dictd \
     dictd-server \
     direnv \
     dnscrypt-proxy \
     duff \
     editorconfig \
     emacs \
     emacs-notmuch \
	 firefox \
     foot \
     foot-terminfo \
     helix \
     helix-parsers \
     helix-themes \
     htop \
     iotop-c \
     isync \
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
     mutt \
     netcat \
     nmap \
     ps_mem \
     restic \
     rlwrap \
     sbcl \
     signify \
     ssmtp \
     syncthing \
     syncthing-tools \
     thunderbird \
     thunderbird-librnp-rnp \
     tig \
     tree-sitter-cli \
     vdirsyncer \
     vdirsyncer-doc \
     w3m \
     wlopm \
     zig \
     zig-doc \
     zig-libs \
     zoxide

dnf5 -y copr enable scottames/ghostty
dnf5 -y install ghostty
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable scottames/ghostty

# Install 1Password app.
echo -e 'yes\n' | rpm --import https://downloads.1password.com/linux/keys/1password.asc
# Stable channel.
#echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://downloads.1password.com/linux/keys/1password.asc" > /etc/yum.repos.d/1password.repo
# Beta channel.
#echo -e "[1password]\nname=1Password Beta Channel\nbaseurl=https://downloads.1password.com/linux/rpm/beta/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://downloads.1password.com/linux/keys/1password.asc" > /etc/yum.repos.d/1password.repo
# Nightly channel, if you feel brave.
echo -e "[1password]\nname=1Password Edge Channel\nbaseurl=https://downloads.1password.com/linux/rpm/edge/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://downloads.1password.com/linux/keys/1password.asc" > /etc/yum.repos.d/1password.repo
dnf5 -y install 1password

systemctl enable dictd
systemctl enable dnscrypt-proxy.service
systemctl enable podman.socket
