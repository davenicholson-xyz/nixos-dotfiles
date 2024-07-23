# flake for development environment. Rename to flake.nix
# echo "use flake" > .envrc
#
# More info https://www.youtube.com/watch?v=yQwW8dkuHqw

{
    description = "Flake for development environment.";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    outputs = {self, nixpkgs, ...}: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in  
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
          # packages here
          ];

          shellHook = ''
          # echo "Using nodejs"
          '';
      };
    };
  }
