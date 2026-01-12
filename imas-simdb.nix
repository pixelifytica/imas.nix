{
  buildPythonPackage,
  fetchFromGitHub,
  pythonRelaxDepsHook,
  setuptools,
  wheel,
  setuptools-scm,
  tomli,
  cerberus,
  pyjwt,
  appdirs,
  argcomplete,
  backports-datetime-fromisoformat,
  click,
  click-option-group,
  distro,
  email-validator,
  numpy,
  python-dateutil,
  pyyaml,
  requests,
  semantic-version,
  sqlalchemy,
  urllib3,
  imas-python,
  ...
}:
buildPythonPackage rec {
  pname = "imas-simdb";
  version = "0.14.0";
  pyproject = true;
  src = fetchFromGitHub {
    owner = "iterorganization";
    repo = "SimDB";
    rev = "${version}";
    hash = "sha256-XQaHH9zCSQVrI4njiTkPmXWkQ0XRDQbJtAfNgI79PZo=";
  };
  nativeBuildInputs = [ pythonRelaxDepsHook ];
  pythonRemoveDeps = true;
  build-system = [
    setuptools
    wheel
    setuptools-scm
    tomli
  ];
  dependencies = [
    cerberus
    pyjwt
    appdirs
    argcomplete
    backports-datetime-fromisoformat
    click
    click-option-group
    distro
    email-validator
    numpy
    python-dateutil
    pyyaml
    requests
    semantic-version
    sqlalchemy
    urllib3
    imas-python
  ];
}
