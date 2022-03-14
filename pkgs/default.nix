self: super: {
  devito = super.callPackage ./devito {
    buildPythonPackage = super.buildPythonPackage;
    matplotlib = super.matplotlib;
    anytree = super.anytree;
    pytest-cov = super.pytest-cov;
    codecov = super.codecov;
    nbval = super.nbval;
    flake8 = super.flake8;
    numpy = super.numpy;
    sympy = super.sympy;
    scipy = super.scipy;
    cached-property = super.cached-property;
    psutil = super.psutil;
    py-cpuinfo = super.py-cpuinfo;
    cgen = super.cgen;
    multidict = super.multidict;
    distributed = super.distributed;
    pytest = super.pytest;
    pytest-runner = super.pytest-runner;
    codepy = super.callPackage ./codepy { };
    pyrevolve = super.callPackage  ./pyrevolve {
      contexttimer = super.callPackage ./contexttimer {
        buildPythonPackage = super.buildPythonPackage;
      };
    };
  };
}
