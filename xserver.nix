{ config, pkgs, lib, ... }:

{

  services.kmonad = {
    enable = true;
    keyboards.myKMonadKeyboard = {
      device = "/dev/input/by-path/pci-0000:07:00.3-usb-0:4:1.0-event-kbd";	
      config = builtins.readFile ./layout.kbd;
    };
  };


  programs.ssh.askPassword = lib.mkForce "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";


  services = {
    displayManager = { 
      sddm.enable = true;
      sddm.wayland.enable = false;
    };    


    desktopManager.plasma6.enable = true;
    desktopManager.gnome.enable = true;

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      inputClassSections = [
        ''
          Identifier "IgnoreTablet"
          MatchIsTablet "on"
          MatchVendor "Wacom|Huion|Gaomon"
          Option "Ignore" "on"
        ''
      ];



    };
  };

  # Define que queremos X11
  environment.sessionVariables = {
    XDG_SESSION_TYPE = "x11";
  };

  # inputs.xmonad-contexts = {
  #   url = "github:Procrat/xmonad-contexts";
  #   flake = false;
  # };
  
}
 # xkb = {
 #   layout = "us";
 #   options = "caps:swapescape";
 # };
 # displayManager = {
 #   sddm.enable = true;
 #   sddm.wayland.enable = false;
 # };





