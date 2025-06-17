{
  buildPythonPackage,
  fetchPypi,
  setuptools,
  numpy,
  vtk,
  imas-python,
}:
buildPythonPackage rec {
  pname = "imas-paraview";
  version = "2.1.0";
  pyproject = true;
  src = fetchPypi {
    inherit version;
    pname = "imas_paraview";
    sha256 = "e7250efcf0d3d8a937de710e1d1557c7f2715dcc48fd7bd0691435565587372d";
  };
  build-system = [ setuptools ];
  dependencies = [
    numpy
    vtk
    imas-python
  ];
}
