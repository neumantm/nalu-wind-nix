{ stdenv
, lib
, fetchFromGitHub
, cmake
, gfortran
, trilinos
, libyamlcpp
, mpi
, hdf5-mpi
, hypre
}:

stdenv.mkDerivation rec {
  pname = "nalu-wind";
  version = "cb801b5";

  src = fetchFromGitHub {
    owner = "Exawind";
    repo = "nalu-wind";
    rev = "1aa1328d635a39fb2bfdfe948e80223ddebc8d98";
    sha256 = "sha256-5CWseQAOdpStEGbHC6TheWS6aIyahZ+lMAZMnAoJJfk=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ cmake gfortran ];

  buildInputs = [
    trilinos
    libyamlcpp
    mpi
    hypre
  ];

  preConfigure = ''
    cmakeFlagsArray+=(
      -DCMAKE_CXX_FLAGS:STRING="-O2 -march=native -mtune=native"
      -DMPIEXEC_PREFLAGS:STRING="--use-hwthread-cpus --oversubscribe"
      -DCMAKE_BUILD_TYPE:STRING=RELEASE
      -DENABLE_DOCUMENTATION:BOOL=OFF
      -DENABLE_TESTS:BOOL=ON
      -DENABLE_HYPRE:BOOL=ON
    )
  '';

  meta = with lib; {
    description = " Solver for wind farm simulations targeting exascale computational platforms ";
    longDescription = ''
      Nalu-Wind is a generalized, unstructured, massively parallel, incompressible flow solver for wind turbine and wind
      farm simulations. The codebase is a wind-focused fork of NaluCFD; NaluCFD is developed and maintained by
      Sandia National Laboratories. Nalu-Wind is being actively developed and maintained by a dedicated, multi-
      institutional team from National Renewable Energy Laboratory, Sandia National Laboratories, and Univ. of Texas
      Austin.
    '';
    homepage = "https://github.com/Exawind/nalu-wind";
    platforms = platforms.all;
  };
}
