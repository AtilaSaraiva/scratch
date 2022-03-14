{ lib, buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  pname = "contexttimer";
  version = "0.3.3";

  src = fetchPypi {
    inherit pname version;
    sha256 = "35a1efd389af3f1ca509f33ff23e17d98b66c8fde5ba2a4eb8a8b7fa456598a5";
  };

  meta = with lib; {
    homepage = "https://github.com/brouberol/contexttimer";
    description = "A timer as a context manager";
    license = licenses.gpl3Only;
    platforms = platforms.all;
  };
}
