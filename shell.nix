{
  pkgs ? import <nixpkgs> {},
  fenix ? import <fenix> {},
}: let
  getLibFolder = pkg: "${pkg}/lib";
in
  pkgs.stdenv.mkDerivation {
    name = "sark-dev";

    nativeBuildInputs = with pkgs; [
      # LLVM & GCC
      gcc
      cmake
      gnumake
      pkg-config
      llvmPackages.llvm
      llvmPackages.clang

      # Hail the Nix
      nixd
      statix
      deadnix
      alejandra

      # Rust
      rustc
      cargo
      clippy
      cargo-watch
      rust-analyzer

      # Embedded
      qemu
      rustfilt
      cargo-binutils
    ];

    buildInputs = with pkgs; [openssl];

    # Set Environment Variables
    RUST_BACKTRACE = 1;
    NIX_LDFLAGS = "-L${(getLibFolder pkgs.libiconv)}";
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
      pkgs.gcc
      pkgs.libiconv
      pkgs.llvmPackages.llvm
    ];

    shellHook = ''
      # Extra steps
    '';
  }
