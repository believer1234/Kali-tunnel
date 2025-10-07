#!/bin/bash
# ==========================================================
# kali-tunnel: Cloudflare Tunnel Installer for Kali/Debian
# Author: Believer
# ==========================================================

echo "🔄 Updating system..."
sudo apt update -y && sudo apt upgrade -y

echo "📦 Installing dependencies..."
sudo apt install wget curl -y

echo "⬇️ Downloading Cloudflared..."
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb

echo "📦 Installing Cloudflared..."
sudo dpkg -i cloudflared-linux-amd64.deb || sudo apt --fix-broken install -y

echo "✅ Cloudflared installed successfully!"
cloudflared --version