shopt -s globstar
shopt -s dotglob
ln -sf /nix/persist/home/user/.dotfiles/files/common/.config/* ~/.config/
ln -sf /nix/persist/home/user/.dotfiles/files/common/.cache/* ~/.cache/
ln -sf /nix/persist/home/user/.dotfiles/files/common/home/* ~/
ln -sf /nix/persist/home/user/.dotfiles/files/common/.local/state/* ~/.local/state/
ln -sf /nix/persist/home/user/.dotfiles/files/common/.local/share/* ~/.local/share/
ln -sf /nix/persist/home/user/.dotfiles/files/common/.local/bin/* ~/.local/bin/

mkdir ~/.config/FreeTube
ln -sf ~/.dotfiles/files/common/FreeTube/* ~/.config/FreeTube/

ln -sfn ~/Persistent/Documents ~/
ln -sfn ~/Persistent/Documents/Projects ~/
ln -sfn ~/Persistent/Music ~/
ln -sfn ~/Persistent/Pictures ~/
ln -sfn ~/Persistent/shared ~/
ln -sfn ~/Persistent/Videos ~/

sleep 1
# ibus-daemon -drx
# sleep 1
# ibus engine hangul
mullvad connect
