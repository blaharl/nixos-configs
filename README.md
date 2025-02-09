# Personal NixOS settings and dotfiles

My personal NixOS config

tmpfs as root & home + btrfs + full disk encryption + impermanence + hyprland
(plasma module included)

# installation

please refer to the links below.

- [Impermanent NixOS](https://willbush.dev/blog/impermanent-nixos/)
- [NixOS tmpfs as home](https://elis.nu/blog/2020/06/nixos-tmpfs-as-home/)
- [NixOS tmpfs as root](https://elis.nu/blog/2020/05/nixos-tmpfs-as-root/)

# flake usage

```bash
# append to enable flakes temporarily
--experimental-features 'nix-command flakes'

sudo nixos-rebuild switch --flake .
sudo nixos-rebuild switch --flake .#nameofconfigurationinflake
nix flake update

nix-shell '<home-manager>' -A install

home-manager switch

home-manger switch --flake .
home-manger switch --flake .#nameofconfigurationinflake

home-manager generations

# rollback HM
/nix/store/...-home-manager-generation/activate
```

## search options -> [mynixos](https://mynixos.com)

- option + home-manager
- option + nixpkgs/option

# useful docs

### nixos wiki

- [impermanence](https://nixos.wiki/wiki/Impermanence)
- [flakes](https://nixos.wiki/wiki/Flakes)
- [hyprland](https://wiki.nixos.org/wiki/Hyprland)
- [libvirt](https://nixos.wiki/wiki/Libvirt)
- [virt-manager](https://nixos.wiki/wiki/Virt-manager)
- [linux kernel](https://nixos.wiki/wiki/Linux_kernel)
- [full disk encryption](https://wiki.nixos.org/wiki/Full_Disk_Encryption)
- [amd gpu](https://wiki.nixos.org/wiki/AMD_GPU)

### nixos manual

- [manual](https://nixos.org/manual/nixos/stable/)
- [options](https://nixos.org/manual/nixos/stable/options)

### hyprland

- [hyprland wiki](https://wiki.hyprland.org/)

# acknowledgements

### NixOS

- [nixos-titus](https://github.com/ChrisTitusTech/nixos-titus)
- [setup for unlocking LUKS using ssh](https://oblivious.observer/posts/nixos-20.03-luks-zfs-kvm/)

### Hyprland

- [ML4W dotfiles](https://github.com/mylinuxforwork/dotfiles)
- [Matt's (linuxcast) dotfiles](https://gitlab.com/thelinuxcast/my-dots)
- [hyprland-titus](https://github.com/ChrisTitusTech/hyprland-titus)
