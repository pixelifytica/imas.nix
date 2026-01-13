{
  pythonOlder,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  setuptools-scm,
  wheel,
  tomli,
  numpy,
  vtk,
  imas-python,
}:
buildPythonPackage rec {
  disabled = pythonOlder "3.8";
  pname = "imas-paraview";
  version = "2.1.0";
  pyproject = true;
  src = fetchFromGitHub {
    owner = "iterorganization";
    repo = "IMAS-Paraview";
    rev = version;
    hash = "sha256-N6dLEpzMK0DJsO1/gSBdGtyJJj2jgmIelKstSYYnzLM=";
  };
  build-system = [
    setuptools
    wheel
    setuptools-scm
  ]
  ++ (if pythonOlder "3.11" then [ tomli ] else [ ]);
  dependencies = [
    numpy
    vtk
    imas-python
  ];
}
