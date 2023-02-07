{ stdenv
, lib
, fetchFromGitHub
, cmake
, gfortran
, trilinos
, libyamlcpp
, mpi
}:

stdenv.mkDerivation rec {
  pname = "nalu-wind-utils";
  version = "ae571b9";

  src = fetchFromGitHub {
    owner = "Exawind";
    repo = "wind-utils";
    rev = "ae571b914bf27adaa7a569be5d590840d0f6cb48";
    sha256 = "sha256-JHTPyF1SKGl2Y45hRrIzhvfRtpbRfo/H36UvdJ0Qt98=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ cmake gfortran ];

  buildInputs = [
    trilinos
    libyamlcpp
    mpi
  ];

  preConfigure = ''
    cmakeFlagsArray+=(
      -DCMAKE_BUILD_TYPE:STRING=RELEASE
    )
  '';

  meta = with lib; {
    description = "Repository for various utilities for Nalu wind-specific simulations.";
    longDescription = ''
      This is a companion software library to Nalu-Wind a generalized, unstructured, massively parallel,
      incompressible flow solver for wind turbine and wind farm simulations. As the name indicates,
      this software repository provides various meshing, pre- and post-processing utilities
      for use with the Nalu CFD code to aid setup and analysis of wind energy LES problems.
      This software is licensed under Apache License Version 2.0 open-source license.
    '';
    homepage = "https://github.com/Exawind/wind-utils";
    platforms = platforms.all;
  };
}
