# Nixos

```bash
git clone https://github.com/eatmore01/nixos.git
mv nixos ~/.nixos

rm /home/<user>/.nixos/hosts/hardware-configuration.nix
# rm ~/.nixos/hosts/hardware-configuration.nix

sudo cp /etc/nixos/hardware-configuration.nix /home/<user>/.nixos/hosts/hardware-configuration.nix
# sudo cp /etc/nixos/hardware-configuration.nix ~/.nixos/hosts/hardware-configuration.nix

sudo chown <user>:users /home/<user>/.nixos/hosts/hardware-configuration.nix
# sudo chown etm:users ~/.nixos/hosts/hardware-configuration.nix

sudo nixos-rebuild switch --flake /home/<users>/.nixos#etm
# sudo nixos-rebuild switch --flake ~/.nixos#etm
```

- recreate hardware-configuration.nix and configuration.nix
```bash
sudo nixos-generate-config
```

- i3status and sway not support move tray form after to before bar =(

- customization `flake.nix`;
```
        gpu = {
          intel = {
            enable = false;
          };
          nvidia = {
            enable = true;
            openSource = true; # nouveau for sway
          };
        };

        wms = {
          sway = {
            enable = true;
            statusBar = "waybar"; # or i3status ( dont use with xfce )
            twoScreen = false;
          };
          # XFCE DOESNT WORK
          xfce = {
            enable = false;
            twoScreen = false;
          };
        };
```