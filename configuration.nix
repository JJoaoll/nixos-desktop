# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./pkgs.nix
      ./xserver.nix 
      ./xmonad.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "draell-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Fortaleza";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };
  
  environment.sessionVariables = {
    GTK_IM_MODULE = "xim";
    QT_IM_MODULE = "xim";
    XMODIFIERS = "@im=none";
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    pulse.enable      = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.draell = {
    isNormalUser = true;
    description  = "João Lucas de Moraes Pereira";
    extraGroups  = [
      "networkmanager"
      "wheel"
      "libvirtd" # VM
      "kvm"      # VM
      #"docker"
   ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;

  #--GAMING STUFF---------------------------------------------------------------------------- 
  # Enable Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Optional: Open ports for Remote Play
    dedicatedServer.openFirewall = true; # Optional: Open ports for Dedicated Servers
  };
  #--GAMING STUFF---------------------------------------------------------------------------- 
	
	# More VM things.
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;  # For Windows VMs (optional)
      ovmf.enable  = true;   # For UEFI support (optional)
    };
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "${pkgs.gamescope}/bin";
    GDK_BACKEND = "x11";
  };
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  
  # exploration:
  # -----------------------------------------------------------------
  system.autoUpgrade.enable = true;
  # system.autoUpgrade.allowReboot = true;


  services.flatpak.enable = true;
  # Enable XDG Desktop Portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # programs.git.enable = true;
  # programs.fzf.enable = true;
  # -----------------------------------------------------------------
  
  system.stateVersion = "unstable"; # Did you read the comment?

}
