{
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  numpy,
  vtk,
  imas-python,
}:
buildPythonPackage rec {
  pname = "imas-paraview";
  version = "2.1.0";
  pyproject = true;
  src = fetchFromGitHub {
    owner = "iterorganization";
    repo = "IMAS-Python";
    rev = version;
    hash = "sha256-o9T9eKla09J89DxEHDSxSrQ4WFrf4GKNWbN9SFL0V/M=";
  };
  build-system = [ setuptools ];
  dependencies = [
    numpy
    vtk
    imas-python
  ];
}
