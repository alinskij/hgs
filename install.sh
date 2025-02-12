#!/bin/bash

# Installing dependencies

cd; echo -e "\e[1;32mInstalling dependencies...\e[m"
sudo pacman -S wget nerd-fonts qt5-wayland qt6-wayland xdg-desktop-portal-hyprland hyprland hyprlock hyprpaper hyprpolkitagent rofi-wayland waybar kitty starship nwg-look thunar parole mousepad

# Configuring starship

echo -e "\e[1;32mConfiguring starship...\e[m"
shell=$(ps -p $$ -o comm=)
if [[ $shell == "bash" ]]; then
    echo "eval "$(starship init bash)"" >> ~/.bashrc
elif [[ $shell == "zsh" ]]; then
    echo "eval "$(starship init zsh)"" >> ~/.zshrc
elif [[ $shell == "fish" ]]; then
    echo "starship init fish | source" >> ~/.config/fish/config.fish
fi

# Backuping old configs

echo -e "\e[1;32mBackuping old configs...\e[m"
tar -cf hgs_backup.tar ~/.config/hypr ~/.config/waybar ~/.config/rofi ~/.config/starship.toml ~/.config/kitty ~/.config/gtk-4.0

# Importing new configs

echo -e "\e[1;32mImporting new configs...\e[m"
cp -rf ~/hgs/dots/hypr ~/.config
cp -rf ~/hgs/dots/kitty ~/.config
cp -rf ~/hgs/dots/rofi ~/.config
cp -rf ~/hgs/dots/waybar ~/.config
cp -f ~/hgs/dots/starship.toml ~/.config
cp -rf ~/hgs/hgs-pctrs ~/Pictures

# Installing gruvbox theme

echo -e "\e[1;32mInstalling theme, icons and cursors...\e[m"
git clone -q https://github.com/sainnhe/capitaine-cursors
mv -f ~/capitaine-cursors ~/capitaine; sudo mv -rf ~/capitaine /usr/share/icons
git clone -q https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme
sudo mv -f ~/Gruvbox-GTK-Theme/icons/Gruvbox-Dark /usr/share/icons; rm -rf Gruvbox-GTK-Theme
cp -rf ~/hgs/dots/gtk-4.0 ~/.config

# All done

echo -e "\e[1;32mAll done!\e[m"
