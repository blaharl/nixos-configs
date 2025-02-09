shopt -s globstar
shopt -s dotglob

ln -s ~/.dotfiles/files/hyprland/.config/* ~/.config/
if [ $DEVICE_IS_PC = 1 ]; then
  ln -sfn /nix/persist/home/user/.dotfiles/files/hyprland/hypr/device/desktop.conf /nix/persist/home/user/.dotfiles/files/hyprland/hypr/include/device.conf
else
  ln -sfn /nix/persist/home/user/.dotfiles/files/hyprland/hypr/device/laptop.conf /nix/persist/home/user/.dotfiles/files/hyprland/hypr/include/device.conf
fi
ln -sfn /nix/persist/home/user/.dotfiles/files/hyprland/hypr/* /home/user/.config/hypr/
