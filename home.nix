{ config, pkgs, combinedPkgs, ...}:

{
  home.username = "anon";
  home.homeDirectory = "/home/anon";
  home.stateVersion = "25.05";

  home.packages = with combinedPkgs; [
    gnomeExtensions.dash-to-dock
  ];  

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [ "dash-to-dock@micxgx.gmail.com" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-fixed = true;
      extend-height = true;
      dock-position = "LEFT";
      intellihide = false;
    };
  };
}
