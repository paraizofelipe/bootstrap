#!/bin/bash

LINUXBASE=$(cat /etc/os-release | grep ID_LIKE | cut -d = -f 2)

case "$LINUXBASE" in
    arch) INSTALL="pacman --noconfirm --needed -Sy" ;;
    debian) INSTALL="apt -y install" ;;
esac


function install_ohmyzsh() {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function install_delta() {
    PACKAGE=git-delta_0.8.3_amd64
    wget -c https://github.com/dandavison/delta/releases/download/0.8.3/$PACKAGE.deb 
    dpkg -i $PACKAGE.deb 
    rm $PACKAGE.deb
}

function install_base() {
    if [ $LINUXBASE = "arch" ]; then
        ${INSTALL} $(< ./packages/arch/base.list)
    else
        ${INSTALL} $(< ./packages/debian/base.list)
    fi

    install_ohmyzsh
    install_delta
}

function install_fonts() {
    # Hack nerdfont
    wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf -P ~/.local/share/fonts/
    wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Bold/complete/Hack%20Bold%20Nerd%20Font%20Complete%20Mono.ttf -P ~/.local/share/fonts/
    wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Italic/complete/Hack%20Italic%20Nerd%20Font%20Complete%20Mono.ttf -P ~/.local/share/fonts/
}

function install_golang() {
    wget -c https://golang.org/dl/go1.16.6.linux-amd64.tar.gz
    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.6.linux-amd64.tar.gz && rm go1.16.6.linux-amd64.tar.gz
}

function install_nodejs() {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
}

function install_python3() {
    curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
}

# Steps
install_base
install_fonts
install_golang
install_nodejs
install_python3
