#!/bin/bash

# ------------ COLORS ------------
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${CYAN}🚀 Starting full DevOps bootstrap setup...${NC}"

# ------------ SYSTEM UPDATE ------------
echo -e "${YELLOW}🔄 Updating system packages...${NC}"
sudo apt update -y && sudo apt upgrade -y

# ------------ CORE UTILS ------------
echo -e "${CYAN}🧰 Installing core utilities...${NC}"
sudo apt install -y curl wget git unzip zip tar gnupg lsb-release software-properties-common apt-transport-https ca-certificates build-essential jq htop tree python3 python3-pip python-is-python3 openjdk-11-jdk

# ------------ DOCKER INSTALL ------------
echo -e "${CYAN}🐳 Installing Docker & Docker Compose...${NC}"
sudo apt remove -y docker docker-engine docker.io containerd runc || true
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  gpg --dearmor | sudo tee /etc/apt/keyrings/docker.gpg > /dev/null
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker $USER

# ------------ AWS CLI INSTALL ------------
echo -e "${CYAN}☁️ Installing AWS CLI...${NC}"
curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip > /dev/null
sudo ./aws/install
rm -rf awscliv2.zip aws

# ------------ AZURE CLI INSTALL ------------
echo -e "${CYAN}☁️ Installing Azure CLI...${NC}"
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# ------------ GCP CLI INSTALL (gcloud) ------------
echo -e "${CYAN}☁️ Installing Google Cloud CLI...${NC}"
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
  | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
  sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt update -y && sudo apt install -y google-cloud-sdk

# ------------ TERRAFORM INSTALL ------------
echo -e "${CYAN}🛠️ Installing Terraform...${NC}"
T_VERSION="1.6.6"
curl -fsSL "https://releases.hashicorp.com/terraform/${T_VERSION}/terraform_${T_VERSION}_linux_amd64.zip" -o terraform.zip
unzip terraform.zip
sudo mv terraform /usr/local/bin/
rm terraform.zip

# ------------ KUBECTL INSTALL ------------
echo -e "${CYAN}📦 Installing kubectl...${NC}"
curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# ------------ HELM INSTALL ------------
echo -e "${CYAN}📦 Installing Helm...${NC}"
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | \
  sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt update
sudo apt install -y helm

# ------------ K9s INSTALL ------------
echo -e "${CYAN}👀 Installing k9s...${NC}"
K9S_VERSION=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | grep tag_name | cut -d '"' -f 4)
curl -L "https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz" -o k9s.tar.gz
tar -xzf k9s.tar.gz
sudo mv k9s /usr/local/bin/
rm k9s.tar.gz

# ------------ VS CODE INSTALL ------------
echo -e "${CYAN}🖥️ Installing Visual Studio Code...${NC}"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update -y
sudo apt install -y code
rm packages.microsoft.gpg

# ------------ ZSH + Oh My Zsh ------------
echo -e "${CYAN}⚙️ Installing Zsh and Oh My Zsh...${NC}"
sudo apt install -y zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo -e "${GREEN}🎨 Oh My Zsh installed. You can now customize ~/.zshrc${NC}"

# ------------ DONE ------------
echo -e "${GREEN}🎉 All tools installed successfully! Please restart your terminal.${NC}"
echo -e "${YELLOW}➡️ Run 'newgrp docker' to use Docker without sudo immediately.${NC}"
