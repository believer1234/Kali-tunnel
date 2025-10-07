#!/bin/bash
# ==========================================================
# kali-tunnel: Uninstall Cloudflared and scripts
# ==========================================================

echo "🗑️ Stopping Cloudflare Tunnel..."
pkill cloudflared || true

echo "📦 Removing Cloudflared..."
sudo apt remove --purge cloudflared -y

echo "🧹 Removing repo scripts..."
rm -rf $(pwd)

echo "✅ Uninstallation complete!"