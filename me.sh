#/bin/bash


sudo nixos-generate-config

rm ~/.nixos/hosts/hardware-configuration.nix
sudo cp /etc/nixos/hardware-configuration.nix ~/.nixos/hosts/hardware-configuration.nix
sudo chown etm:users ~/.nixos/hosts/hardware-configuration.nix


echo "COMMENT PACKAGES WHITCH DONT AVAILABLE IN RUSSIAN"

# sudo nixos-rebuild switch --flake ~/.nixos#etm
