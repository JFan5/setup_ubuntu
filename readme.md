# Ubuntu Setup Script

This script automates the installation and configuration of essential tools and development environments on a fresh Ubuntu system. It sets up commonly used tools, configures Zsh with Oh My Zsh, installs Miniconda for Python environment management, Docker for containerization, and Visual Studio Code as a code editor.

## Features

- **Essentials**: Installs Git, Zsh, SSH, net-tools, curl, wget, vim, build-essential, htop, tmux, unzip, Node.js, npm, and other useful utilities.
- **Zsh**: Sets Zsh as the default shell and installs Oh My Zsh with the zsh-autosuggestions plugin.
- **Miniconda**: Installs Miniconda for Python package and environment management.
- **codex**: Installs the `@openai/codex` CLI globally via npm for immediate availability.
- **llmstl environment**: Creates a dedicated Conda environment named `llmstl` with Python 3.10 and installs the `llmstl` package.
- **Docker**: Installs Docker for containerized application deployment and adds the current user to the Docker group for non-root usage.
- **Visual Studio Code**: Installs VS Code as the default code editor.
- **SSH Key Generation**: Automatically generates a 4096-bit RSA SSH key if one is not already present.

## Prerequisites

- This script is intended for Ubuntu-based systems.
- Run the script with `sudo` permissions to ensure all installations and configurations complete successfully.

## Installation

1. Clone this repository or download the script file:

   ```bash
   git clone <repository_url>
   cd <repository_directory>
   ```

2. Make the script executable:

   ```bash
   chmod +x setup.sh
   ```

3. Run the script with `sudo`:

   ```bash
   sudo ./setup.sh
   ```

   > **Note**: Running with `sudo` is required for installing packages and configuring system settings.

## Components Installed

1. **Basic Utilities**:
   - `git`, `zsh`, `openssh-server`, `net-tools`, `autojump`, `curl`, `wget`, `vim`, `build-essential`, `htop`, `tmux`, `unzip`, `zip`, `tree`, `software-properties-common`, `ca-certificates`, `apt-transport-https`, `gnupg`, `nodejs`, and `npm`.

2. **Zsh with Oh My Zsh**:
   - Sets Zsh as the default shell.
   - Installs Oh My Zsh and `zsh-autosuggestions` plugin for enhanced command-line experience.

3. **Miniconda**:
   - Installs Miniconda to manage Python environments and packages.
   - Automatically configures Conda to initialize in Zsh.

4. **Docker**:
   - Installs Docker CE and configures the current user to run Docker without `sudo`.
   - You may need to log out and back in for the Docker group changes to take effect.

5. **Visual Studio Code**:
   - Adds Microsoft’s repository and installs the latest version of Visual Studio Code.

6. **codex CLI**:
   - Installs the `@openai/codex` CLI globally using npm.

7. **llmstl Conda Environment**:
   - Creates the `llmstl` Conda environment pinned to Python 3.10.
   - Installs the `llmstl` package inside the environment for immediate use.

8. **SSH Key Generation**:
   - Generates a 4096-bit RSA SSH key if one does not already exist.

## Post-Installation

- **Restart the terminal** or **log out and log back in** to apply changes, such as the Zsh default shell and Docker group membership.
- Open Visual Studio Code using `code` in the terminal.

## Troubleshooting

If you encounter issues:
- Verify you have an active internet connection.
- Ensure your Ubuntu system is up-to-date with `sudo apt update && sudo apt upgrade`.

## License

This setup script is open source and free to use under the [MIT License](LICENSE).
