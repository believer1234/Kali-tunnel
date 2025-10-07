# Kali-tunnel
Update setup-tunnel.sh to Include Auto-Start

Add the following after the tunnel is started (Step 4/5 in the script):

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


---

2️⃣ How It Works

1. The script creates a systemd service named kali-tunnel.service.


2. The service runs the exact command used to start the tunnel.


3. It’s set to restart on failure automatically.


4. It’s enabled in multi-user.target, so it starts whenever Kali boots.


5. Users can manually stop or check it with:



# Stop the tunnel
sudo systemctl stop kali-tunnel.service

# Start it again
sudo systemctl start kali-tunnel.service

# Check status
sudo systemctl status kali-tunnel.service


---

3️⃣ Complete Flow for Users

After cloning your GitHub repo:

git clone https://github.com/<username>/kali-tunnel.git
cd kali-tunnel
chmod +x setup-tunnel.sh
sudo ./setup-tunnel.sh

Then:

1. Enter the local port (e.g., 8080).


2. Tunnel starts immediately and shows the public URL.


3. Tunnel will now auto-start on every boot.




---

✅ Benefits

True one-time setup

No need to manually start tunnel after reboot

Logs still accessible in tunnel.log

Systemd handles auto-restarts if it crashes

