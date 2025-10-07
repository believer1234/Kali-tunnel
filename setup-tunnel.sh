#!/bin/bash
# ==========================================================
# kali-tunnel: All-in-One Cloudflare Tunnel Installer & Starter
# Author: Believer
# ==========================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🌐 Kali Cloudflare Tunnel All-in-One Installer${NC}"
echo "----------------------------------------------------"

# Step 1: Update & install dependencies
echo -e "${GREEN}[1/5] Updating system and installing dependencies...${NC}"
sudo apt update -y && sudo apt upgrade -y
sudo apt install wget curl -y

# Step 2: Download & install Cloudflared
echo -e "${GREEN}[2/5] Downloading and installing Cloudflared...${NC}"
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared-linux-amd64.deb || sudo apt --fix-broken install -y
rm cloudflared-linux-amd64.deb
echo -e "${GREEN}✅ Cloudflared installed: $(cloudflared --version)${NC}"

# Step 3: Set all .sh scripts as executable
echo -e "${GREEN}[3/5] Setting permissions for all scripts...${NC}"
chmod +x *.sh
echo "✅ Permissions set!"

# Step 4: Ask for local port & start tunnel
echo -e "${GREEN}[4/5] Starting your tunnel...${NC}"
read -p "💻 Enter your local port to forward (e.g., 8080): " PORT

cloudflared tunnel --url http://localhost:$PORT --no-autoupdate > tunnel.log 2>&1 &
sleep 3

# Step 5: Display public URL
echo -e "${GREEN}[5/5] Tunnel started! Your public URL:${NC}"
URL=$(grep -m 1 -o "https://[-a-z0-9]*\.trycloudflare\.com" tunnel.log)
echo -e "${BLUE}$URL${NC}"

echo ""
echo -e "${GREEN}✅ All done! Your tunnel is live.${NC}"
echo "🔁 To stop tunnel: pkill cloudflared"
echo "📂 Logs saved in tunnel.log"
# Step 6: Create systemd service for auto-start
echo -e "${GREEN}[6/6] Creating systemd service for auto-start...${NC}"

SERVICE_FILE="/etc/systemd/system/kali-tunnel.service"

sudo bash -c "cat > $SERVICE_FILE" <<EOF
[Unit]
Description=Kali Cloudflare Tunnel Service
After=network.target

[Service]
Type=simple
ExecStart=$(which cloudflared) tunnel --url http://localhost:$PORT --no-autoupdate
Restart=on-failure
User=$USER
WorkingDirectory=$(pwd)

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd daemon and enable service
sudo systemctl daemon-reload
sudo systemctl enable kali-tunnel.service
sudo systemctl start kali-tunnel.service

echo -e "${GREEN}✅ Systemd service created! Tunnel will auto-start on boot.${NC}"