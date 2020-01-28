{ stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  pname = "range-v3";
  version = "0.10.0";

  src = fetchFromGitHub {
    owner = "ericniebler";
    repo = "range-v3";
    rev = version;
    sha256 = "1h9h5j7pdi0afpip9ncq76h1xjhvb8bnm585q17afz2l4fydy8qj";
  };

  nativeBuildInputs = [ cmake ];

  # Building the tests currently fails on AArch64 due to internal compiler
  # errors (with GCC 9.2):
  cmakeFlags = stdenv.lib.optional stdenv.isAarch64 "-DRANGE_V3_TESTS=OFF";

  doCheck = !stdenv.isAarch64;
  checkTarget = "test";

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "Experimental range library for C++11/14/17";
    homepage = https://github.com/ericniebler/range-v3;
    license = licenses.boost;
    platforms = platforms.all;
    maintainers = with maintainers; [ primeos xwvvvvwx ];
  };
}
