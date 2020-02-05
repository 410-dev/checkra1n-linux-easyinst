#!/bin/bash
if [[ "$EUID" -ne 0 ]]; then
	echo "Not enough permission. Please type your password to elevate the permission."
	echo "Password will not be sent to anywhere."
	sudo echo "Successfully elevated privillage."
else
	echo "Superuser permission is already granted."
fi
echo "[1/6] Setting outputs..."
OUTPUTD="$HOME/CheckRa1nEasyInstLog.txt"
touch "$OUTPUTD"
echo "[2/6] Adding CheckRa1n repo to APT repositories..."
sudo echo "deb https://assets.checkra.in/debian /" >> /etc/apt/sources.list
echo "[3/6] Receiving GPG key..."
sudo apt-key adv --fetch-keys https://assets.checkra.in/debian/archive.key >> "$OUTPUTD"
echo "[4/6] Updating APT..."
sudo apt update >> "$OUTPUTD"
echo "[5/6] Installing CheckRa1n and its dependencies..."
sudo apt-get install checkra1n -y >> "$OUTPUTD"
echo "[6/6] Creating alias..."
DESKT="$HOME/Desktop"
echo "sudo checkra1n" > "$DESKT/CheckRa1n.sh"
chmod +x "$DESKT/CheckRa1n.sh"
echo "Finished installing CheckRa1n. Would you start now? (y/n)"
read booleand
if [[ "$booleand" == "Y" ]] || [[ "$booleand" == "y" ]]; then
	echo "Starting CheckRa1n."
	clear
	sudo checkra1n
	exit $?
else
	echo "Finishing installation assistant."
	exit 0
fi