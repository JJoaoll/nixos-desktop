{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url        = "github:NixOS/nixpkgs/nixos-unstable";
    # xmonad-contrib.url = "github:xmonad/xmonad-contrib";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.draell-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}
