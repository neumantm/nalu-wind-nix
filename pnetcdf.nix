{ stdenv
, lib
, fetchzip
, gnum4
, gfortran
, mpi
}:

stdenv.mkDerivation rec {
  pname = "pnetcdf";
  version = "1.12.3";

  src = fetchzip {
    url = "https://parallel-netcdf.github.io/Release/pnetcdf-${version}.tar.gz";
    sha256 = "sha256-YYM00m3woCh6FDTPoU6zK4pbIoPfUt4Qengenz+JKzI=";
  };

  nativeBuildInputs = [ gnum4 gfortran ];

  buildInputs = [
    mpi
  ];

  meta = with lib; {
    description = "Parallel I/O library for accessing Unidata's NetCDF files in classic formats.";
    longDescription = ''
      PnetCDF is a high-performance parallel I/O library for accessing Unidata's NetCDF, files in classic formats,
      specifically the formats of CDF-1, 2, and 5. CDF-1 is the default NetCDF classic format.
      CDF-2 is an extended format created through using flag NC_64BIT_OFFSET to support 64-bit file offsets.
      The CDF-5 file format, an extension of CDF-2 and created through using flag NC_64BIT_DATA,
      supports unsigned data types and uses 64-bit integers to allow users to define large dimensions, attributes,
      and variables (> 2B array elements).
    '';
    homepage = "https://parallel-netcdf.github.io";
    platforms = platforms.all;
  };
}
