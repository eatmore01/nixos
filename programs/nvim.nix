{
  inputs,
  home-manager,
  pkgs,
  vars,
  ...
}:
{
  home-manager.users.${vars.user} = {
    imports = [
      inputs.nixvim.homeModules.nixvim
    ];

    programs.nixvim = {
      enable = true;

      opts = {
        number = true;
        relativenumber = true;
        clipboard = "unnamedplus";
        tabstop = 2;
        softtabstop = 2;
        showtabline = 2;
        expandtab = true;
        smartindent = true;
        shiftwidth = 2;
        breakindent = true;
        cursorline = true;
        scrolloff = 8;
        mouse = "a";
        foldmethod = "manual";
        foldenable = false;
        linebreak = true;
        spell = false;
        swapfile = false;
        timeoutlen = 300;
        termguicolors = true;
        showmode = true;
        splitbelow = true;
        splitkeep = "screen";
        splitright = true;
        cmdheight = 0;
        fillchars = {
          eob = " ";
        };
      };

      keymaps = [
        # Global
        {
          key = "<C-b>";
          action = "<CMD>NvimTreeToggle<CR>";
          options.desc = "Toggle NvimTree";
        }
      ];

      plugins = {
        nvim-tree = {
          enable = true;
          openOnSetupFile = true;
          settings.auto_reload_on_write = true;
        };
      };
    };
  };
}
