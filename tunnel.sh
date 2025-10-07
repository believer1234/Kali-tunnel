#!/bin/bash
# ==========================================================
# kali-tunnel: Start a Cloudflare Tunnel
# Author: Believer
# ==========================================================

echo "🌐 Cloudflare Tunnel Tool for Kali"
echo "----------------------------------"

# Ask for the local port
read -p "Enter the local port to forward (e.g., 8080): " PORT

# Start tunnel
echo "🚀 Starting tunnel for localhost:$PORT ..."
cloudflared tunnel --url http://localhost:$PORT --no-autoupdate > tunnel.log 2>&1 &

sleep 3

# Show public URL
echo "📜 Your public tunnel URL:"
grep -m 1 -o "https://[-a-z0-9]*\.trycloudflare\.com" tunnel.log

echo ""
echo "✅ Tunnel is live! Copy the URL above."
echo "🔁 To stop tunnel: pkill cloudflared"