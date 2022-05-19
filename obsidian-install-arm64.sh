#!/usr/bin/env bash
# Original -> https://forum.obsidian.md/t/gnome-desktop-installer/499

# Set icon & appimage variables
icon_url="https://cdn.discordapp.com/icons/686053708261228577/1361e62fed2fee55c7885103c864e2a8.png"
dl_url=$( curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest  \
	| grep "browser_download_url.*AppImage" | head -n 1 | cut -d '"' -f 4 )

# Download icon & appimage
printf "Downloading files...\n"
curl --location --output Obsidian.AppImage "$dl_url"
curl --location --output obsidian.png "$icon_url"

# Check old files
FILES="/usr/share/pixmaps/obsidian.png
/usr/bin/obsidian
/opt/obsidian/Obsidian.AppImage"

# Remove old files
for file in $FILES
do
	if [[ -f  "$file" ]]; then
		printf "Removing: $file\n"
		sudo rm $file
	fi
done

# Prepare directories
sudo mkdir --parents /opt/obsidian/
sudo mv Obsidian.AppImage /opt/obsidian
sudo chmod u+x /opt/obsidian/Obsidian.AppImage
sudo mv obsidian.png /opt/obsidian
sudo ln -s /opt/obsidian/obsidian.png /usr/share/pixmaps
mkdir --parents /home/$USER/.local/share/applications

# Launcher values
echo "[Desktop Entry]
Type=Application
Name=Obsidian
Exec=/opt/obsidian/Obsidian.AppImage
Icon=obsidian
Terminal=false" > ~/.local/share/applications/obsidian.desktop

# Refresh and finish
update-desktop-database ~/.local/share/applications
sudo ln -s /opt/obsidian/Obsidian.AppImage /usr/bin/obsidian
printf "Installation Complete..."
