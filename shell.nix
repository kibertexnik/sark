{
  pkgs ? import <nixpkgs> {},
  fenix ? import <fenix> {},
}: let
  getLibFolder = pkg: "${pkg}/lib";

  # Rust Toolchain
  target = "aarch64-unknown-none-softfloat";
  toolchain = with fenix.packages.${pkgs.system};
    combine [
      complete.rustc
      complete.cargo
      complete.clippy
      complete.rust-analyzer
      complete.llvm-tools-preview
      targets.${target}.latest.rust-std
    ];
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
      toolchain
      cargo-watch

      # Testing
      ruby

      # Embedded
      qemu
      rustfilt
      cargo-binutils
    ];

    buildInputs = with pkgs; [openssl];

    # Set Environment Variables
    RUST_BACKTRACE = 1;
    CARGO_BUILD_TARGET = target;
    CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER = let
      inherit (pkgs.pkgsCross.aarch64-multiplatform.stdenv) cc;
    in "${cc}/bin/${cc.targetPrefix}cc";
    NIX_LDFLAGS = "-L${(getLibFolder pkgs.libiconv)}";
    # RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
      pkgs.gcc
      pkgs.libiconv
      pkgs.llvmPackages.llvm
    ];

    shellHook = ''
      # Extra steps
    '';
  }
