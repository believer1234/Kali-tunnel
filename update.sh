#!/bin/bash
# ==========================================================
# kali-tunnel: Update Cloudflared and scripts
# ==========================================================

echo "🔄 Updating Kali packages..."
sudo apt update -y && sudo apt upgrade -y

echo "⬇️ Downloading latest Cloudflared..."
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared-linux-amd64.deb || sudo apt --fix-broken install -y
rm cloudflared-linux-amd64.deb

echo "✅ Cloudflared updated!"
cloudflared --version