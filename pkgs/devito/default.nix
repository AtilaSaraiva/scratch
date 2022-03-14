{ stdenv, lib, buildPythonPackage, fetchFromGitHub, matplotlib, anytree, pytest-cov, codecov, nbval, flake8, numpy, sympy, scipy, cached-property, gcc, psutil, py-cpuinfo, cgen, click, multidict, distributed, pytest, pytest-runner, pyrevolve, codepy }:


buildPythonPackage rec {
  pname = "devito";
  version = "4.6.2-bbad3b1";

  src = fetchFromGitHub {
    repo = "devito";
    owner = "devitocodes";
    rev = "bbad3b17be8c9061ca1967760827b2e4b1f11afe";
    sha256 = "1yd89jh897fkc7089smgnxmgkvwkd0bsap1i93ixmh7pwzjsbdm3";
  };

  # Required flags from https://github.com/cvxgrp/cvxpy/releases/tag/v1.1.11

  preCheck = ''
    export CFLAGS="-fopenmp"
    export LDFLAGS="-lgomp"
    export LD_PRELOAD="${gcc.cc.lib}/lib/libgomp.so"
    export CFLAGS="-fopenmp"
  '';

  doCheck = false;

  propagatedBuildInputs = [ anytree pytest-cov codecov nbval flake8 multidict distributed
                            pyrevolve pyrevolve codepy numpy sympy psutil py-cpuinfo cgen
                            click scipy cached-property];

  buildInputs = [ matplotlib pytest pytest-runner ];

  postFixup = ''
    echo "print('oi')" >> $out/lib/python3.9/site-packages/devito/__init__.py
  '';

  meta = with lib; {
    homepage = "https://www.devitoproject.org/";
    description = "Code generation framework for automated finite difference computation";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
