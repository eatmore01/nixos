{ vars, home-manager, ... }:
{
  home-manager.users.${vars.user} = {
    programs.foot = {
      enable = true;

      settings = {
        main = {
          font = "monospace:size=13";
        };

        cursor = {
          style = "beam";
          blink = "yes";
        };

        colors = {
          background = "000000";
        };
      };
    };
  };
}
