# Nixos

```bash
git clone https://github.com/eatmore01/nixos.git
mv nixos ~/.nixos
rm /home/<user>/.nixos/hosts/hardware-configuration.nix
sudo cp /etc/nixos/hardware-configuration.nix /home/<user>/.nixos/hosts/hardware-configuration.nix
sudo chown <user>:users /home/<user>/.nixos/hosts/hardware-configuration.nix

sudo nixos-rebuild switch --flake ~/.nixos#etm
# sudo nixos-rebuild switch --flake /home/<users>/.nixos#etm
```

- recreate hardware-configuration.nix and configuration.nix 
```bash
sudo nixos-generate-config
```

- i3status and sway not support move tray form after to before bar =(

- customization `flake.nix`;
```
42       gpu = "nvidia"; # or intel
43       status_bar = "i3status"; # or waybar
```