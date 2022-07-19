#!/bin/bash

LINUXBASE=$(cat /etc/os-release | grep ID_LIKE | cut -d = -f 2)

case "$LINUXBASE" in
    arch) INSTALL="sudo pacman --noconfirm --needed -Sy" ;;
    debian) INSTALL="sudo apt -y install" ;;
esac


function install_ohmyzsh() {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

function install_delta() {
    PACKAGE=git-delta_0.8.3_amd64
    wget -c https://github.com/dandavison/delta/releases/download/0.8.3/$PACKAGE.deb 
    sudo dpkg -i $PACKAGE.deb 
    rm $PACKAGE.deb
}

function install_bat() {
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat
}

function install_base() {
    if [ $LINUXBASE = "arch" ]; then
        ${INSTALL} $(< ./packages/arch/base.list)
    else
        ${INSTALL} $(< ./packages/debian/base.list)
    fi

    install_ohmyzsh
    install_delta
    install_bat
}

function install_fonts() {
    # Hack nerdfont
    wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf -P ~/.local/share/fonts/
    wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Bold/complete/Hack%20Bold%20Nerd%20Font%20Complete%20Mono.ttf -P ~/.local/share/fonts/
    wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Italic/complete/Hack%20Italic%20Nerd%20Font%20Complete%20Mono.ttf -P ~/.local/share/fonts/
}

function install_golang() {
    $last=$(wget -qO- https://golang.org/dl/ | grep -oP 'go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1)
    wget -c https://golang.org/dl/$last_version
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf $last && rm $last
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
install_golang
install_fonts
install_nodejs
install_python3
