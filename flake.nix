{
  description = "Microkernel for Kibertexnik";

  inputs = {
    # Too old to work with most libraries
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # Perfect!
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Rust toolchain shit
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # The flake-thing libraries
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    fenix,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem
    (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        # Nix script formatter
        formatter = pkgs.alejandra;

        # Development environment
        devShells.default = import ./shell.nix {inherit pkgs fenix;};

        # Output package
        packages = {
          # Image for Raspberry Pi 3
          rpi3 = pkgs.callPackage ./. {
            inherit pkgs fenix;
            bsp = "rpi3";
          };
          # Image for Raspberry Pi 4
          rpi4 = pkgs.callPackage ./. {
            inherit pkgs fenix;
            bsp = "rpi4";
          };
          # Image for Raspberry Pi 5
          rpi5 = pkgs.callPackage ./. {
            inherit pkgs fenix;
            bsp = "rpi5";
          };
          # Defaulted to Raspberry Pi 3
          default = pkgs.callPackage ./. {inherit pkgs fenix;};
        };
      }
    );
}
