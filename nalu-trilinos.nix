{ stdenv
, lib
, fetchFromGitHub
, blas
, boost
, cmake
, gfortran
, lapack
, mpi
, swig
, zlib
, hdf5-mpi
, netcdf-mpi
, pnetcdf
, superlu
, trilinos-rev
, trilinos-src-hash
}:

let
  flags = ''
    -G "Unix Makefiles"
    -DBUILD_SHARED_LIBS=ON
    -DCMAKE_CXX_FLAGS="-O3 -fPIC"
    -DCMAKE_C_FLAGS="-O3 -fPIC"
    -DCMAKE_Fortran_FLAGS="-O3 -fPIC"
    -DCMAKE_C_COMPILER=mpicc
    -DCMAKE_CXX_COMPILER=mpic++
    -DCMAKE_Fortran_COMPILER=mpif77

    -DCMAKE_BUILD_TYPE:STRING=RELEASE
    -DMPI_USE_COMPILER_WRAPPERS:BOOL=ON

    -DKokkos_ENABLE_DEPRECATED_CODE:BOOL=OFF
    -DTpetra_INST_SERIAL:BOOL=ON
    -DTrilinos_ENABLE_CXX11:BOOL=ON
    -DTrilinos_ENABLE_EXPLICIT_INSTANTIATION:BOOL=ON
    -DTpetra_INST_DOUBLE:BOOL=ON
    -DTpetra_INST_COMPLEX_DOUBLE:BOOL=OFF
    -DTrilinos_ENABLE_TESTS:BOOL=OFF
    -DTrilinos_ENABLE_ALL_OPTIONAL_PACKAGES:BOOL=OFF
    -DTrilinos_ASSERT_MISSING_PACKAGES:BOOL=OFF
    -DTrilinos_ALLOW_NO_PACKAGES:BOOL=OFF
    -DTrilinos_ENABLE_Epetra:BOOL=OFF
    -DTrilinos_ENABLE_Tpetra:BOOL=ON
    -DTrilinos_ENABLE_KokkosKernels:BOOL=ON
    -DTrilinos_ENABLE_ML:BOOL=OFF
    -DTrilinos_ENABLE_MueLu:BOOL=ON
    -DXpetra_ENABLE_Kokkos_Refactor:BOOL=ON
    -DMueLu_ENABLE_Kokkos_Refactor:BOOL=ON
    -DTrilinos_ENABLE_EpetraExt:BOOL=OFF
    -DTrilinos_ENABLE_AztecOO:BOOL=OFF
    -DTrilinos_ENABLE_Belos:BOOL=ON
    -DTrilinos_ENABLE_Ifpack2:BOOL=ON
    -DTrilinos_ENABLE_Amesos2:BOOL=ON
    -DTrilinos_ENABLE_Zoltan2:BOOL=ON
    -DTrilinos_ENABLE_Ifpack:BOOL=OFF
    -DTrilinos_ENABLE_Amesos:BOOL=OFF
    -DTrilinos_ENABLE_Zoltan:BOOL=ON
    -DTrilinos_ENABLE_STK:BOOL=ON
    -DTrilinos_ENABLE_Gtest:BOOL=ON
    -DTrilinos_ENABLE_SEACASExodus:BOOL=ON
    -DTrilinos_ENABLE_SEACASEpu:BOOL=ON
    -DTrilinos_ENABLE_SEACASExodiff:BOOL=ON
    -DTrilinos_ENABLE_SEACASNemspread:BOOL=ON
    -DTrilinos_ENABLE_SEACASNemslice:BOOL=ON
    -DTrilinos_ENABLE_SEACASIoss:BOOL=ON
    -DTPL_ENABLE_MPI:BOOL=ON
    -DTPL_ENABLE_Boost:BOOL=ON
    -DTPL_ENABLE_SuperLU:BOOL=ON
    -DTPL_ENABLE_Netcdf:BOOL=ON
    -DTPL_Netcdf_PARALLEL:BOOL=ON
    -DTPL_ENABLE_Pnetcdf:BOOL=ON
    -DTPL_ENABLE_HDF5:BOOL=ON
    -DHDF5_NO_SYSTEM_PATHS:BOOL=ON
    -DTPL_ENABLE_Zlib:BOOL=ON
    -DTPL_ENABLE_BLAS:BOOL=ON
  '';

in
stdenv.mkDerivation rec {
  pname = "trilinos";
  version = trilinos-rev;

  src = fetchFromGitHub {
    owner = "trilinos";
    repo = "Trilinos";
    rev = trilinos-rev;
    sha256 = trilinos-src-hash;
  };

  nativeBuildInputs = [ cmake gfortran swig ];

  buildInputs = [ boost pnetcdf ];

  propagatedBuildInputs = [ blas lapack mpi zlib hdf5-mpi netcdf-mpi superlu ];

  preConfigure =
    ''
      cmakeFlagsArray+=(${flags})
    '';

  meta = with lib; {
    description = "Engineering and scientific problems algorithms";
    longDescription = ''
      The Trilinos Project is an effort to develop algorithms and enabling
      technologies within an object-oriented software framework for the
      solution of large-scale, complex multi-physics engineering and scientific
      problems.
    '';
    homepage = "https://trilinos.org";
    license = licenses.bsd3;
    platforms = platforms.all;
  };
}
