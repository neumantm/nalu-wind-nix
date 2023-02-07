{
  description = "A flake for building nalu-wind and nalu-wind-utils";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
        let pkgs = import nixpkgs { system = "${system}"; }; in {
          packages = rec {
            pnetcdf = pkgs.callPackage ./pnetcdf.nix { };
            hypre = pkgs.callPackage ./hypre.nix { };
            netcdf-mpi = pkgs.netcdf-mpi.overrideAttrs ( old: {
              buildInputs = old.buildInputs ++ [ pnetcdf ];
              configureFlags = old.configureFlags ++ [
                "--enable-pnetcdf"
              ];
            });
            nalu-trilinos = pkgs.callPackage ./nalu-trilinos.nix {
              inherit netcdf-mpi pnetcdf;
              trilinos-rev = "933f1f0986d6f6808abb4ec670f0f66468ea573a";
              trilinos-src-hash = "sha256-MQXIWS354kFWqbk+TtymcSPpiSXUOoQ0vZEIhSnwE0E=";
            };
            utils-trilinos = pkgs.callPackage ./nalu-trilinos.nix {
              inherit netcdf-mpi pnetcdf;
              trilinos-rev = "trilinos-release-13-2-0";
              trilinos-src-hash = "sha256-RwBUMNasVXV1L+hr3i0ms0p2DJju7v5tY/BjexIaLwU=";
            };
            nalu-wind = pkgs.callPackage ./nalu-wind.nix { trilinos = nalu-trilinos; inherit hypre; };
            nalu-wind-utils = pkgs.callPackage ./nalu-wind-utils.nix { trilinos = utils-trilinos; };
            default = pkgs.symlinkJoin {
              name = "nalu-wind-with-utils";
              meta.mainProgramm = "naluX";
              paths = [
                nalu-wind
                nalu-wind-utils
              ];
            };
          };
        }
    );
}
