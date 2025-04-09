#!/bin/bash

# Colors
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🔄 Updating package index...${NC}"
sudo apt update -y

echo -e "${YELLOW}📦 Installing Git...${NC}"
sudo apt install -y git

echo -e "${GREEN}✅ Git installed successfully!${NC}"
echo -e "${GREEN}🧪 Git version:$(git --version)${NC}"
echo -e "\n"
echo -e "${GREEN}✅ R C B ✅.${NC}"
echo -e "${GREEN}   ✅ R C B ✅.${NC}"
echo -e "${GREEN}       ✅ R C B ✅.${NC}"
echo -e "${GREEN}           ✅ R C B ✅.${NC}"
echo -e "${GREEN}               ✅ R C B ✅.${NC}"
echo -e "\n"