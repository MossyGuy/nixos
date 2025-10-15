{ config, pkgs, combinedPkgs, ... }: 

{
  imports = [ ./hardware-configuration.nix ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  # Kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "Europe/Ljubljana";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sl_SI.UTF-8";
    LC_IDENTIFICATION = "sl_SI.UTF-8";
    LC_MEASUREMENT = "sl_SI.UTF-8";
    LC_MONETARY = "sl_SI.UTF-8";
    LC_NAME = "sl_SI.UTF-8";
    LC_NUMERIC = "sl_SI.UTF-8";
    LC_PAPER = "sl_SI.UTF-8";
    LC_TELEPHONE = "sl_SI.UTF-8";
    LC_TIME = "sl_SI.UTF-8";
  };

  # Gnome
  services.gnome.core-apps.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
 
  # Hyprland
  programs.hyprland = {
    enable = true;
    package = combinedPkgs.hyprland;
    portalPackage = combinedPkgs.xdg-desktop-portal-hyprland;
  };  

  # Stylix
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml";

  # Keyboard layout
  console.keyMap = "slovene";
  services.xserver.xkb = {
    layout = "si";
    variant = "";
  };

  # Printing
  services.printing.enable = true;

  # Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Users
  users.users.anon = {
    isNormalUser = true;
    description = "anon";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with combinedPkgs; [ # with pkgs
    brrtfetch
    ghostty
    wget
    yaru-theme
    zen-browser
    fastfetch
    vim
  ];

  # System version
  system.stateVersion = "25.05"; 
}
