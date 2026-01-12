{
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  setuptools-scm,
  wheel,
  numpy,
  rich,
  scipy,
  click,
  packaging,
  xxhash,
  imas-data-dictionaries,
  imas-core,
}:
buildPythonPackage rec {
  pname = "imas-python";
  version = "2.1.0-post1";
  pyproject = true;
  src = fetchFromGitHub {
    owner = "iterorganization";
    repo = "IMAS-Python";
    rev = version;
    hash = "sha256-o9T9eKla09J89DxEHDSxSrQ4WFrf4GKNWbN9SFL0V/M=";
  };
  build-system = [
    setuptools
    wheel
    numpy
    packaging
    setuptools-scm
  ];
  dependencies = [
    numpy
    rich
    scipy
    click
    packaging
    xxhash
    imas-data-dictionaries
    imas-core
  ];
}
