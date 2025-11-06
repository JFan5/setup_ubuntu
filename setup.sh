#!/bin/bash

# Update package list and install essential software
sudo apt update && sudo apt -y install \
    git \
    zsh \
    openssh-server \
    net-tools \
    autojump \
    curl \
    wget \
    vim \
    build-essential \
    htop \
    tmux \
    unzip \
    zip \
    tree \
    software-properties-common \
    ca-certificates \
    apt-transport-https \
    gnupg \
    nodejs \
    npm

# Enable and start SSH service
sudo systemctl enable --now ssh

# Set Zsh as the default shell
chsh -s $(which zsh)

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed"
fi

# Install zsh-autosuggestions plugin
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
else
    echo "zsh-autosuggestions plugin is already installed"
fi

# Download and install Miniconda
if [ ! -d "$HOME/miniconda3" ]; then
    echo "Downloading and installing Miniconda..."
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
    bash ~/miniconda.sh -b -p $HOME/miniconda3
    rm ~/miniconda.sh
    echo 'export PATH="$HOME/miniconda3/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
    conda init zsh
    conda update -y conda
else
    echo "Miniconda is already installed"
fi

# Install codex CLI globally via npm
if command -v npm &> /dev/null; then
    if ! npm list -g --depth=0 | grep -q "@openai/codex"; then
        echo "Installing @openai/codex globally via npm..."
        sudo npm i -g @openai/codex
    else
        echo "@openai/codex is already installed globally"
    fi
else
    echo "npm not found. Skipping @openai/codex installation."
fi

# Generate SSH key if it does not already exist
SSH_KEY_PATH="$HOME/.ssh/id_rsa"
if [ ! -f "$SSH_KEY_PATH" ]; then
    echo "Generating SSH key..."
    mkdir -p "$HOME/.ssh"
    ssh-keygen -t rsa -b 4096 -C "$USER@$(hostname)" -N "" -f "$SSH_KEY_PATH"
else
    echo "SSH key already exists at $SSH_KEY_PATH"
fi

# Install Docker
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update && sudo apt -y install docker-ce docker-ce-cli containerd.io
    sudo usermod -aG docker $USER
    newgrp docker
else
    echo "Docker is already installed"
fi

# Install Visual Studio Code
if ! command -v code &> /dev/null; then
    echo "Installing Visual Studio Code..."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
    sudo apt update && sudo apt -y install code
    rm packages.microsoft.gpg
else
    echo "Visual Studio Code is already installed"
fi

# Load Zsh configuration (if running in Zsh)
if [ -n "$ZSH_VERSION" ]; then
    source ~/.zshrc
fi

echo "System setup complete. Please restart your terminal or log out and log back in to use the Zsh, Miniconda, Docker, and Visual Studio Code environments."

