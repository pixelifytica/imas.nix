{
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  setuptools-scm,
  packaging,
  ...
}:
buildPythonPackage rec {
  pname = "imas-data-dictionaries";
  version = "4.1.0";
  pyproject = true;
  src = fetchFromGitHub {
    owner = "iterorganization";
    repo = "IMAS-Data-Dictionaries";
    rev = version;
    hash = "sha256-E8Mv+8wcwVK42u9u8CgFlVru3aRDJ2ynJSx5OIB+Vu0=";
  };
  build-system = [
    setuptools
    setuptools-scm
    packaging
  ];
  dependencies = [ packaging ];
}
