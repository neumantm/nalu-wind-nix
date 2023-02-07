# nalu-wind-nix

Nix package definition for nalu-wind

## Packaged software

This repository packages [nalu-wind](https://github.com/Exawind/nalu-wind) commit [1aa1328 (Feb 7, 2023)](https://github.com/Exawind/nalu-wind/commit/1aa1328d635a39fb2bfdfe948e80223ddebc8d98)\
and [nalu-wind-utils](https://github.com/Exawind/wind-utils) commit [ae571b9 (Mar 29, 2021)](https://github.com/Exawind/wind-utils/commit/ae571b914bf27adaa7a569be5d590840d0f6cb48).

Additionally, package definitions for the dependencies that are not (yet) in nixpkgs are also included.

## Installation

This repository is a [Nix Flake](https://nixos.wiki/wiki/Flakes).

To use it you need to

- have the [Nix Package Manager](https://nixos.org/)
- have [Nix Flakes enabled](https://nixos.wiki/wiki/Flakes#Enable_flakes)
- Enter a shell with the flake: `nix shell github:neumantm/nalu-wind-nix`
- Now you can just run `naluX` as well as the util binaries like `abl_mesh`.
