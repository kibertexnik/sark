{
  pkgs ? import <nixpkgs> {},
  fenix ? import <fenix> {},
}: let
  lib = pkgs.lib;
  getLibFolder = pkg: "${pkg}/lib";
  manifest = (pkgs.lib.importTOML ./Cargo.toml).package;

  # Rust Toolchain
  target = "aarch64-unknown-none-softfloat";
  toolchain = fenix.packages.${pkgs.system}.fromToolchainFile {
    file = ./rust-toolchain.toml;
    sha256 = "sha256-0Hcko7V5MUtH1RqrOyKQLg0ITjJjtyRPl2P+cJ1p1cY=";
  };
in
  pkgs.rustPlatform.buildRustPackage {
    pname = "sark";
    version = manifest.version;
    cargoLock.lockFile = ./Cargo.lock;
    src = pkgs.lib.cleanSource ./.;

    nativeBuildInputs = with pkgs; [
      # LLVM & GCC
      gcc
      cmake
      gnumake
      pkg-config
      gcc-arm-embedded
      llvmPackages.llvm
      llvmPackages.clang

      # Rust
      toolchain

      # Testing & Deployment
      ruby
      bundler

      # Embedded
      qemu
      rustfilt
      cargo-binutils
    ];

    buildInputs = with pkgs; [
      qemu
      openssl
      libressl
    ];

    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
      pkgs.gcc
      pkgs.libiconv
      pkgs.gcc-arm-embedded
      pkgs.llvmPackages.llvm
    ];

    RUST_BACKTRACE = 1;
    RUSTFLAGS = "-C target-cpu=cortex-a53 -C link-arg=--library-path=./src/bsp/raspberrypi -C link-arg=--script=kernel.ld -D warnings -D missing_docs";
    CARGO_BUILD_TARGET = target;
    CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER = let
      inherit (pkgs.pkgsCross.aarch64-multiplatform.stdenv) cc;
    in "${cc}/bin/${cc.targetPrefix}cc";
    NIX_LDFLAGS = "-L${(getLibFolder pkgs.libiconv)}";

    meta = with lib; {
      homepage = manifest.workspace.package.homepage;
      description = "Sokhibjon's ARM RaspberryPi Kernel";
      license = with lib.licenses; [asl20];
      platforms = with platforms; linux ++ darwin;

      maintainers = [
        {
          name = "Sokhibjon Orzikulov";
          email = "sakhib@orzklv.uz";
          handle = "orzklv";
          github = "orzklv";
          githubId = 54666588;
          keys = [
            {
              fingerprint = "00D2 7BC6 8707 0683 FBB9  137C 3C35 D3AF 0DA1 D6A8";
            }
          ];
        }
      ];
    };
  }
