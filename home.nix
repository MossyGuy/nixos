{ config, pkgs, inputs, combinedPkgs, mango, ...}:

{
  imports = [ mango.hmModules.mango inputs.zen-browser.homeModules.beta ];
  home.username = "tilen";
  home.homeDirectory = "/home/tilen";
  home.stateVersion = "25.05";

  home.packages = with combinedPkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.user-themes
    yaru-theme    

    jetbrains.idea-community
    scala
    vlang
    jdk25
    brrtfetch
    ghostty
    wget
    fastfetch
    vim
  ];  
  
  programs.zen-browser = {
    enable = true;
  };

  programs.git = {
    enable = true;
    settings.user.name = "MossyGuy";
    settings.user.email = "tilen@pogacnik.net";
  };
  
  wayland.windowManager.mango = {
    enable = true;
    settings = ''
    bind=SUPER,l,quit
    bind=SUPER,Return,spawn,ghostty
    bind=SUPER,q,killclient
    bind=SUPER,e,spawn,nautilus

    bind=SUPER,Right,focusdir,right
    bind=SUPER,Left,focusdir,left
    bind=SUPER,Up,focusdir,up
    bind=SUPER,Down,focusdir,down

    bind=SUPER,1,comboview,1
    bind=SUPER,2,comboview,2
    bind=SUPER,3,comboview,3
    bind=SUPER,4,comboview,4
    bind=SUPER,5,comboview,5
    bind=SUPER,6,comboview,6
    bind=SUPER,7,comboview,7
    bind=SUPER,8,comboview,8
    bind=SUPER,9,comboview,9

    bind=SUPER,c,setlayout,monocle
    bind=SUPER,n,switch_layout

    tagrule=id:1,layoutname_tile
    tagrule=id:2,layoutname_tile
    tagrule=id:3,layoutname_tile
    tagrule=id:4,layoutname_tile
    tagrule=id:5,layoutname_tile
    tagrule=id:6,layoutname_tile
    tagrule=id:7,layoutname_tile
    tagrule=id:8,layoutname_tile
    tagrule=id:9,layoutname_tile

    new_is_master=1
    default_mfact=0.55
    default_nmaster=1
    smartgaps=0

    repeat_rate=25
    repeat_delay=600
    numlockon=0
    xkb_rules_layout=si
    '';

    autostart_sh = ''

    '';
  };

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [ 
        "dash-to-dock@micxgx.gmail.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com" 
      ];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
    };

    #"org/gnome/shell/extensions/user-theme" = {
    #  name = "Yaru-olive-dark";
    #};

    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-fixed = true;
      extend-height = true;
      dock-position = "LEFT";
      intellihide = false;
    };
  };
}
