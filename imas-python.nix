{
  buildPythonPackage,
  fetchPypi,
  setuptools,
  setuptools-scm,
  numpy,
  rich,
  scipy,
  click,
  packaging,
  xxhash,
  saxonche,
  gitpython,
  netcdf4,
}:
buildPythonPackage rec {
  pname = "imas-python";
  version = "2.0.0.post1";
  pyproject = true;
  src = fetchPypi {
    inherit version;
    pname = "imas_python";
    sha256 = "12d9c5eac60d8b2fdf6d5c048057627165fc851fbdd96affc8f8ea28f0ae9614";
  };
  build-system = [
    setuptools
    setuptools-scm
    numpy
    saxonche
    gitpython
  ];
  dependencies = [
    numpy
    rich
    scipy
    click
    packaging
    xxhash
    saxonche
    gitpython
    netcdf4
  ];
}
