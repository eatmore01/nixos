{ vars, git, home-manager, ... }:
{
  home-manager.users.${vars.user} = {
    programs.git = {
      enable = true;
      userName = git.username;
      userEmail = git.email;
    };
  };
}