# Nixos


`flake.nix` -> need to set gpu ( default intel ) 


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
