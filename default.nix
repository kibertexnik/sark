{
  pkgs ? import <nixpkgs> {},
  fenix ? import <fenix> {},
}: let
  lib = pkgs.lib;
  getLibFolder = pkg: "${pkg}/lib";
  manifest = (pkgs.lib.importTOML ./Cargo.toml).package;
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
      llvmPackages.llvm
      llvmPackages.clang

      # Rust
      rustc
      cargo
      clippy

      # Embedded
      rustfilt
      cargo-binutils
    ];

    buildInputs = with pkgs; [
      openssl
      libressl
    ];

    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
      pkgs.gcc
      pkgs.libiconv
      pkgs.llvmPackages.llvm
    ];

    RUST_BACKTRACE = 1;
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
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
