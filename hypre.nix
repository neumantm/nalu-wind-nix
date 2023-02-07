{ stdenv
, lib
, fetchzip
, cmake
, mpi
}:

stdenv.mkDerivation rec {
  pname = "hypre";
  version = "v2.26.0";

  src = fetchzip {
    url = "https://github.com/hypre-space/hypre/archive/refs/tags/${version}.zip";
    sha256 = "sha256-lseh9wdet8pZ0SMww26slggWayM3b94jkca/unpCUNw=";
  };

  sourceRoot = "source/src";

  preConfigure = ''
    cmakeFlagsArray+=(
      -DHYPRE_ENABLE_BIGINT:BOOL=ON
    )
  '';

  nativeBuildInputs = [ cmake ];

  buildInputs = [ mpi ];

  meta = with lib; {
    description = "Parallel solvers for sparse linear systems featuring multigrid methods.";
    longDescription = ''
      HYPRE is a library of high performance preconditioners and solvers featuring multigrid methods
      for the solution of large, sparse linear systems of equations on massively parallel computers.
    '';
    homepage = "https://github.com/hypre-space/hypre";
    platforms = platforms.all;
  };
}
