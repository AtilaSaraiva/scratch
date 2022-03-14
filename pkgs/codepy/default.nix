{ lib, buildPythonPackage, fetchPypi, pytools, numpy, appdirs, six, cgen }:

buildPythonPackage rec {
  pname = "codepy";
  version = "2019.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "384f22c37fe987c0ca71951690c3c2fd14dacdeddbeb0fde4fd01cd84859c94e";
  };

  buildInputs = [ pytools numpy appdirs six cgen ];

  meta = with lib; {
    homepage = "https://github.com/inducer/codepy";
    description = "Generate and execute native code at run time, from Python";
    license = licenses.mit;
    platforms = platforms.all;
  };

}
