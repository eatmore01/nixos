{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
{
  home-manager.users.${vars.user} = {
    # terraform mirror from yandex
    home.file = {
      ".terraformrc" = {
        text = ''
          provider_installation {
            network_mirror {
              url = "https://terraform-mirror.yandexcloud.net/"
              include = ["registry.terraform.io/*/*"]
            }
            direct {
              exclude = ["registry.terraform.io/*/*"]
            }
          }
        '';
      };
    };
  };
}
