{ lib, buildPythonPackage, fetchPypi, contexttimer, versioneer, cython, numpy }:

buildPythonPackage rec {
  pname = "pyrevolve";
  version = "2.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "b49aea5cd6c520ac5fcd1d25fa23fe2c5502741d2965f3eee10be067e7b0efb4";
  };

  buildInputs = [ versioneer cython numpy ];
  propagatedBuildInputs = [ contexttimer ];

  meta = with lib; {
    homepage = "https://github.com/devitocodes/pyrevolve";
    description = "Python library to manage checkpointing for adjoints";
    license = licenses.epl10;
    platforms = platforms.all;
  };
}
