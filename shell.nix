{
  pkgs ? import <nixpkgs> {},
  fenix ? import <fenix> {},
}: let
  getLibFolder = pkg: "${pkg}/lib";

  # Rust Toolchain
  target = "aarch64-unknown-none-softfloat";
  toolchain = fenix.packages.${pkgs.system}.fromToolchainFile {
    file = ./rust-toolchain.toml;
    sha256 = "sha256-0Hcko7V5MUtH1RqrOyKQLg0ITjJjtyRPl2P+cJ1p1cY=";
  };
in
  pkgs.stdenv.mkDerivation {
    name = "sark-dev";

    nativeBuildInputs = with pkgs; [
      # LLVM & GCC
      gcc
      cmake
      gnumake
      pkg-config
      gcc-arm-embedded
      llvmPackages.llvm
      llvmPackages.clang

      # Hail the Nix
      nixd
      statix
      deadnix
      alejandra

      # Rust
      toolchain
      cargo-watch

      # Testing
      ruby
      bundler

      # Embedded
      qemu
      rustfilt
      cargo-binutils
    ];

    buildInputs = with pkgs; [openssl];

    # Set Environment Variables
    RUST_BACKTRACE = 1;
    RUSTFLAGS = "-C target-cpu=cortex-a53 -C link-arg=--library-path=./src/bsp/raspberrypi -C link-arg=--script=kernel.ld -D warnings -D missing_docs";
    CARGO_BUILD_TARGET = target;
    CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER = let
      inherit (pkgs.pkgsCross.aarch64-multiplatform.stdenv) cc;
    in "${cc}/bin/${cc.targetPrefix}cc";
    NIX_LDFLAGS = "-L${(getLibFolder pkgs.libiconv)}";
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
      pkgs.gcc
      pkgs.libiconv
      pkgs.gcc-arm-embedded
      pkgs.llvmPackages.llvm
    ];

    shellHook = ''
      # Extra steps

      ## Setting up ruby bundler with exta configs
      bundle config set --local path 'target/.vendor/bundle'
      bundle config set --local with 'development'
      bundle config build.serialport -- --with-cflags=-Wno-int-conversion

      ## Install all gems
      bundle install

      ## Activate Zed configs
      cp -R ./.github/zed ./.zed
    '';
  }
