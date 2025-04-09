#!/bin/bash

set -e

echo "🧹 Uninstalling conflicting packages..."
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do 
  sudo apt-get remove -y $pkg || true
done

echo "🚀 Updating system packages..."
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "🔐 Adding Docker GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  gpg --dearmor | sudo tee /etc/apt/keyrings/docker.gpg > /dev/null

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "📦 Setting up Docker repo..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🔄 Updating package index again..."
sudo apt update

echo "🐳 Installing Docker Engine and tools..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "✅ Docker installed successfully!"

echo "🔄 Starting Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

echo "👥 Post-install: Adding user '$USER' to docker group..."
sudo groupadd -f docker
sudo usermod -aG docker $USER

echo "🐳 Verifying Docker with hello-world..."
sudo docker run hello-world

echo -e "\n🎉 Done! Docker is installed and running."

echo -e "\n💡 To start using Docker without 'sudo', do either:"
echo " 1. Log out and log back in, or"
echo " 2. Run 'newgrp docker' in the current terminal"
echo "Then try:"
echo " docker run hello-world"
echo "."
echo "."
echo "."
echo -e "\n🎉 Done! Docker is installed and running. Cheers to RCB  🎉"
echo -e "\n🎉🎉🎉🎉🎉🎉🎉🎉🎉 RCB 🎉🎉🎉🎉🎉🎉🎉🎉🎉"
echo -e "\n🎉🎉🎉🎉🎉🎉🎉🎉🎉 RCB 🎉🎉🎉🎉🎉🎉🎉🎉🎉"
echo -e "\n🎉🎉🎉🎉🎉🎉🎉🎉🎉 RCB 🎉🎉🎉🎉🎉🎉🎉🎉🎉"
echo -e "\n🎉🎉🎉🎉🎉🎉🎉🎉🎉 RCB 🎉🎉🎉🎉🎉🎉🎉🎉🎉"
echo -e "\n"