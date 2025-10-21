{ config, pkgs, combinedPkgs, mango, ...}:

{
  imports = [ mango.hmModules.mango ];
  home.username = "tilen";
  home.homeDirectory = "/home/tilen";
  home.stateVersion = "25.05";

  home.packages = with combinedPkgs; [
    gnomeExtensions.dash-to-dock
    yaru-theme    

    brrtfetch
    ghostty
    wget
    zen-browser
    fastfetch
    vim
  ];  

  programs.git = {
    enable = true;
    settings.user.name = "MossyGuy";
    settings.user.email = "tilen@pogacnik.net";
  };
  
  wayland.windowManager.mango = {
    enable = true;
    settings = ''
    
    '';
    autostart_sh = ''

    '';
  };

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
