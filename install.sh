#!/bin/bash

# Installing dependencies

echo -e "\e[1;32mInstalling dependencies...\e[m"
sudo pacman -S wget nerd-fonts qt5-wayland qt6-wayland xdg-desktop-portal-hyprland hyprland hyprlock hyprpaper hyprpolkitagent rofi-wayland waybar kitty starship nwg-look

# Configuring starship

echo -e "\e[1;32mConfiguring starship...\e[m"
shell=$(ps -p $$ -o comm=)
if [[ $shell == "bash" ]]; then
    echo "eval "$(starship init bash)"" >> ~/.bashrc
    source .bashrc
elif [[ $shell == "zsh" ]]; then
    echo "eval "$(starship init zsh)"" >> ~/.zshrc
    source .zshrc
elif [[ $shell == "fish" ]]; then
    echo "starship init fish | source" >> ~/.config/fish/config.fish
    source ~/.config/fish/config.fish
fi

# Backuping old configs

echo -e "\e[1;32mBackuping old configs...\e[m"
tar -cf hgs_backup.tar ~/.config/hypr ~/.config/waybar ~/.config/rofi ~/.config/starship.toml ~/.config/kitty ~/.config/gtk-4.0

# Importing new configs

echo -e "\e[1;32mImporting new configs...\e[m"
cp -f ~/hgs/dots/hypr/* ~/.config/hypr
cp -f ~/hgs/dots/kitty/* ~/.config/kitty
cp -f ~/hgs/dots/rofi/* ~/.config/rofi
cp -f ~/hgs/dots/waybar/* ~/.config/waybar/*
cp -f ~/hgs/dots/starship.toml ~/.config
cp -rf ~/hgs/hgs_wallpapers ~/Pictures

# Installing gruvbox theme

echo -e "\e[1;32mInstalling theme, icons and cursors...\e[m"

wget -q https://github.com/sainnhe/capitaine-cursors/archive/refs/heads/master.tar.gz
tar -xf master.tar.gz; rm -rf master.tar.gz; mv -f ~/master/capitaine-cursors-master ~/master/capitaine
sudo cp -rf ~/master/capitaine /usr/share/icons; rm -rf master

cp -f ~/hgs/dots/gtk/* ~/.config/gtk-4.0

wget -q https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme/archive/refs/heads/master.tar.gz
tar -xf master.tar.gz; rm -rf master.tar.gz; sudo mv -rf ~/master/Gruvbox-GTK-Theme-master/icons/Gruvbox-Dark /usr/share/icons; rm -rf master

echo -e "\e[1;32mAll done!\e[m"

# Confirmation

read -p $'\e[1;32mDo you want to log out to apply the settings? y/n: \e[m' choice
if [ $choice == "y" ]; then
    hyprctl dispatch exit
elif [ $choice == "n" ]; then
    exit 0
fi
