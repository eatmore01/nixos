# Nixos

```bash
git clone https://github.com/eatmore01/nixos.git
mv nixos ~/.nixos
sudo cp /etc/nixos/hardware-configuration.nix /home/<user>/.nixos/hosts/hardware-configuration.nix

sudo nixos-rebuild switch --flake ~/.nixos#etm
```

- recreate hardware-configuration.nix and configuration.nix 
```bash
sudo nixos-generate-config
```