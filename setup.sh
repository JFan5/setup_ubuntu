#!/bin/bash

# 更新软件包列表并安装必要软件
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
    gnupg

# 启用并启动 SSH 服务
sudo systemctl enable --now ssh

# 设置 Zsh 为默认 shell
chsh -s $(which zsh)

# 安装 Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh &&
    sh ~/.oh-my-zsh/tools/install.sh
else
    echo "Oh My Zsh 已安装"
fi

# 安装 zsh-autosuggestions 插件
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
else
    echo "zsh-autosuggestions 插件已安装"
fi

# 下载并安装 Miniconda
if [ ! -d "$HOME/miniconda3" ]; then
    echo "正在下载并安装 Miniconda..."
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
    bash ~/miniconda.sh -b -p $HOME/miniconda3
    rm ~/miniconda.sh
    echo 'export PATH="$HOME/miniconda3/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
    conda init zsh
    conda update -y conda
else
    echo "Miniconda 已安装"
fi

# 安装 Docker
if ! command -v docker &> /dev/null; then
    echo "正在安装 Docker..."
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update && sudo apt -y install docker-ce docker-ce-cli containerd.io
    sudo usermod -aG docker $USER
    newgrp docker
else
    echo "Docker 已安装"
fi

# 安装 VS Code
if ! command -v code &> /dev/null; then
    echo "正在安装 Visual Studio Code..."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
    sudo apt update && sudo apt -y install code
    rm packages.microsoft.gpg
else
    echo "Visual Studio Code 已安装"
fi

# 加载 Zsh 配置（如果已经在 Zsh 中运行）
if [ -n "$ZSH_VERSION" ]; then
    source ~/.zshrc
fi

echo "系统设置完成。请重启终端或重新登录以使用 Zsh、Miniconda、Docker 及 Visual Studio Code 环境。"

