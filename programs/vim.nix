{
  vars,
  host,
  home-manager,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    vim
  ];

  home-manager.users.${vars.user} = {
    programs.vim = {
      enable = true;
      extraConfig = ''
        set nocompatible
        set number
        syntax on
        set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
        set relativenumber
      '';
    };
  };
}
