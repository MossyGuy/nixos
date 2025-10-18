{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    brrtfetch.url = "github:MossyGuy/brrtfetch";
    mango.url = "github:DreamMaoMao/mango";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, mango, zen-browser, brrtfetch, ... } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };      
     
    combinedPkgs = pkgs // {
      zen-browser = zen-browser.packages.${system}.default;
      brrtfetch = brrtfetch.packages.${system}.default;
    };

    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs combinedPkgs; };
        modules = [
          ./configuration.nix 
          mango.nixosModules.mango { programs.mango.enable = true; }
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.anon = import ./home.nix;
              extraSpecialArgs = { inherit combinedPkgs mango; };
            };
          }
        ];
      };
        
      packages.${system} = combinedPkgs;
    };
}
