# ------------ ZSH + Oh My Zsh + Powerlevel10k ------------
echo -e "${CYAN}🎨 Setting up Zsh with Powerlevel10k...${NC}"
sudo apt install -y zsh fonts-powerline
chsh -s $(which zsh)

# Install Oh My Zsh (unattended)
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc

# Meslo Nerd Font (for proper icons)
echo -e "${CYAN}📦 Installing Meslo Nerd Font...${NC}"
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
fc-cache -fv > /dev/null
cd ~

# ------------ VS CODE EXTENSIONS ------------
echo -e "${CYAN}🧩 Installing popular VS Code extensions...${NC}"
code --install-extension ms-azuretools.vscode-docker
code --install-extension hashicorp.terraform
code --install-extension redhat.vscode-yaml
code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
code --install-extension esbenp.prettier-vscode
code --install-extension github.vscode-pull-request-github

# ------------ SSH KEYGEN SETUP ------------
echo -e "${CYAN}🔐 Setting up SSH key (if not present)...${NC}"
if [[ ! -f "$HOME/.ssh/id_rsa" ]]; then
  read -p "Enter email for SSH key (GitHub/Git): " ssh_email
  ssh-keygen -t rsa -b 4096 -C "$ssh_email" -f ~/.ssh/id_rsa -N ""
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa
  echo -e "${GREEN}✔️ SSH key generated!${NC}"
  echo -e "${YELLOW}📋 Your public key:${NC}"
  cat ~/.ssh/id_rsa.pub
  echo -e "${YELLOW}Copy and add it to GitHub: https://github.com/settings/keys${NC}"
else
  echo -e "${GREEN}✅ SSH key already exists, skipping generation.${NC}"
fi

# ------------ DONE ------------
echo -e "${GREEN}🎉 Final setup complete!${NC}"
echo -e "${YELLOW}🧠 Recommended:${NC}"
echo -e "  ➤ Restart your terminal or run: ${CYAN}exec zsh${NC}"
echo -e "  ➤ Set your terminal font to: ${CYAN}MesloLGS NF${NC}"
echo -e "  ➤ Run: ${CYAN}p10k configure${NC} to customize your prompt"

