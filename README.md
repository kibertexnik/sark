<p align="center">
    <img src=".github/assets/header.png" alt="Kibertexnik's {Sark}">
</p>

<p align="center">
    <h3 align="center">Minimal embedded monolith kernel for Raspberry Pi boards.</h3>
</p>

<p align="center">
    <img align="center" src="https://img.shields.io/github/languages/top/kibertexnik/sark?style=flat&logo=rust&logoColor=ffffff&labelColor=242424&color=242424" alt="Top Used Language">
    <a href="https://github.com/kibertexnik/sark/actions/workflows/test.yml"><img align="center" src="https://img.shields.io/github/actions/workflow/status/kibertexnik/sark/test.yml?style=flat&logo=github&logoColor=ffffff&labelColor=242424&color=242424" alt="Test CI"></a>
</p>

## About

After attempting to strip down Linux kernel to remove any unnecessary driver & support and achieve minimal size and performant Linux kernel, another
motivation to write own kernel was born as a research & experiment done afterwork. The main purpose of the project is to attempt to ship embed
software right into kernel itself, so it's native and booting kernel will run everything necessary.

> This project **doesn't accept PRs** as it's very immature and not well shaped yet.
> This project is just an experiment conducted in [Kibertexnik](https://github.com/kibertexnik) and maintained by [@orzklv](https://github.com/orzklv) himself.

## Features

- Written on Rust
- Monolith model
- Raspberry 3, 4, 5
- Conditional targetting
- Embedded software/product

## Development

### Prerequisites

Setting up Rust embedded toolchain is a bit of tidious proceses. Therefore, a few prerequisite software should be installed before you start working with the project.

#### Nix / Nix-less

If you have Nix package manager installed on your machine or your Linux distribution happens to be NixOS, then you're partially ready to go just by executing (I've already done the dirtiest job part for you):

```shell
nix develop -c $SHELL
```

If you don't have Nix package manager installed machine and you want to do everything imperative way, just open [shell.nix:17-45](https://github.com/kibertexnik/sark/blob/26e0660725a2e88f877dea10f686150af737d08e/shell.nix#L17-L45) and install whatever software inside this array. After doing so, you need to install nightly version of Rust programming language toolchain with the exact version stated in [rust-toolchain.toml](https://github.com/kibertexnik/sark/blob/main/rust-toolchain.toml). Also, don't forget to install target specific standard library "rust-src" and components as stated in toolchain file. I don't know what operating system you do use, so you gotta figure out yourself how to get these installed, my responsibility ends at provoding full Nix & Docker dev container support.

#### Docker / Development Image

Make sure to have docker installed on your computer to be able to run development container which will help you to utilize ARM embedded tooling. Well, I'm not going to teach you how to install docker on your PC, you're free to google it. Just make sure it is installed and running on background. _I tried my best to create the dev env entirely on Nix, but imperative nature of [Arm LLC ](https://arm.com) won't let me do so._

After the installation process, you need to decide whether will you build the devkit image from scratch (recommended if you have couple CPU cores biting dust in the corner) or fetch daily built image from our registry.

If you decide to fetch pre-built image:

```shell
docker pull ghcr.io/kibertexnik/sark-dev:main
```

If you decide to build image locally from scratch:

```shell
cd ./.github/docker && make local
```

### Development Environment

Now when you're done with setting up all necessary stuff to proceed with development, a few things you should know:

#### Commands

I wrote a huge ass Makefile to simplify environment & args settings. You can execute:

- `make test` - Run tests to make sure correct kernel behavior
- `make qemu` - Compiling & running compiled image on qemu emulator
- `make clippy` - Linting rust codebase with clippy
- `make clean` - Clean up compiled ojbects and binaries
- `make readelf` - Parse and show ELF header metatags
- `make objdump` - Explore binary's assembly instruction sets
- `make doc` - Open developer documentation (mostly from author)
- `make nm` - Explore binary's command sequence

#### Makefile

There are few properties that can be set to change compilation behavior. Let's start with:

- `BSP` - this property is used to specify the geneartion of raspberry's board to which compiler will compile for and emulate images on. [Refer to for more](https://github.com/kibertexnik/sark/blob/26e0660725a2e88f877dea10f686150af737d08e/Makefile#L23-L68)
- `SERIAL` - specify whether the emulated environment should show assembly of running image or serial outputs. [Refer to for more](https://github.com/kibertexnik/sark/blob/26e0660725a2e88f877dea10f686150af737d08e/Makefile#L28-L32)
- `DOCKER` - use only docker or nix environment in all commands. [WIP]

#### Developer documentation

There are also some developer/maintainer written documentation acrosos all codebases which can be accessed either by running `make doc` or opening [https://kibertexnik.github.io/sark](http://sark.kibertexnik.uz/).

## License

This project is licensed under dual licensing as the Apache-2.0 and MIT License - see the [LICENSE-APACHE](license-apache) or [LICENSE-MIT](license-mit) file for details.

<p align="center">
    <img src=".github/assets/footer.png" alt="Kibertexnik's {Sark}">
</p>
