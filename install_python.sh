#!/bin/bash

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}🔄 Updating package index...${NC}"
sudo apt update -y

echo -e "${GREEN}🐍 Installing python-is-python3 to alias 'python' to 'python3'...${NC}"
sudo apt install -y python-is-python3

echo -e "${GREEN}✅ Done! You can now use 'python' as a command.${NC}"
echo -e "${GREEN}✅ R C B ✅.${NC}"
echo -e "${GREEN}   ✅ R C B ✅.${NC}"
echo -e "${GREEN}       ✅ R C B ✅.${NC}"
echo -e "${GREEN            }✅ R C B ✅.${NC}"
echo -e "${GREEN}               ✅ R C B ✅.${NC}"
echo -e "\n"
