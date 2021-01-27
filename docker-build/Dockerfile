FROM archlinux:latest

VOLUME /_pkg /_build

RUN pacman -Syu --noconfirm --needed base base-devel git tree go
RUN useradd -d /home/makepkg makepkg && \
    mkdir -p /home/makepkg/{.config/pacman,.gnupg,build/{srcdest,srcpkgdest,logdest,build,out}} && \
    echo 'keyserver-options auto-key-retrieve' > /home/makepkg/.gnupg/gpg.conf && \
    echo 'root  ALL=(ALL) ALL' >> /etc/sudoers && \
    echo 'makepkg ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    chown -R makepkg:users /home/makepkg

COPY ap-build /usr/local/bin/
COPY ap-tools.conf /etc/
