{
  python,
  buildPythonPackage,
  fetchPypi,
  cython,
}:
buildPythonPackage rec {
  disabled = !python.isPy310;
  pname = "saxonche";
  version = "12.7.0";
  format = "wheel";
  src = fetchPypi {
    inherit pname version format;
    sha256 = "714216ad9150632dd12cf0747824773d97c66f9b00634cbeacfa34228938007f";
    python = "cp310";
    dist = "cp310";
    abi = "cp310";
    platform = "manylinux_2_24_x86_64";
  };
  buildInputs = [ cython ];
}
