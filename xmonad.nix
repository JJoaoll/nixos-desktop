{ config, pkgs, ... }:

let
  xmonad-contexts = pkgs.fetchFromGitHub {
    owner = "Procrat";
    repo = "xmonad-contexts";
    rev = "main"; # Replace with the specific commit, tag, or branch you need
    sha256 = "YOUR_SHA256_HASH"; # Replace with the correct hash
  };
in
{
  services.xserver = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
      ];
      ghcArgs = [
        "-odir /tmp" # Place object files in /tmp to avoid writing to the Nix store
        "-i${xmonad-contexts}" # Include the xmonad-contexts source path for GHC
      ];
      # config = builtins.readFile /home/draell/.config/xmonad/xmonad.hs;
    };
  };

}
