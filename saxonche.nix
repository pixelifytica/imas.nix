{
  python,
  buildPythonPackage,
  pythonOlder,
  fetchPypi,
  libz,
  cython,
  autoPatchelfHook,
}:
let
  pyversion = with builtins; substring 0 3 (replaceStrings [ "." ] [ "" ] python.version);
  dist = "cp${pyversion}";
  sha256 =
    {
      "310" = "714216ad9150632dd12cf0747824773d97c66f9b00634cbeacfa34228938007f";
      "311" = "262c284f772cad3a18dc06b0d55d4032849083c00049fe24c1e7e67a0c625bff";
      "312" = "fa55ba65344534652498ee6a1de86f32c2a40d273ec48eb996e62be45b9594c2";
      "313" = "b0493b4360ce2d0a2b0d4a493f0027650dd183bd504e837d3848c084a30e59be";
    }
    .${pyversion};
in
buildPythonPackage rec {
  disabled = pythonOlder "3.10";
  pname = "saxonche";
  version = "12.7.0";
  format = "wheel";
  src = fetchPypi {
    inherit
      pname
      version
      format
      dist
      sha256
      ;
    python = dist;
    abi = dist;
    platform = "manylinux_2_24_x86_64";
  };
  buildInputs = [
    libz
    cython
  ];
  nativeBuildInputs = [ autoPatchelfHook ];
}
