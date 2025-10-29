{ config, pkgs, combinedPkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];  

  # Bootloader.
  boot.loader.grub = {
   enable = true;  
   device = "nodev";
   efiSupport = true;
   useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Ljubljana";

  # Select internationalisation properties.
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

  services.desktopManager.gnome.enable = true;
  services.displayManager.ly = {
    enable = true;
    settings = {
      animate = true;
      animation = 1;
    };  
  };

  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";
    polarity = "dark";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "si";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "slovene";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gregor = {
    isNormalUser = true;
    description = "Gregor Pogačnik";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  users.users.tilen = {
    isNormalUser = true;
    description = "Tilen Pogačnik";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  hardware.graphics = {
    enable = true;
    #driSupport = true;
    extraPackages = with pkgs; [ mesa egl-wayland intel-media-driver ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with combinedPkgs; [
    wget
    vim
  ];

  system.stateVersion = "25.05"; # Did you read the comment?

}
