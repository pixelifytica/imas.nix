{
  python,
  buildPythonPackage,
  pythonOlder,
  fetchPypi,
  autoPatchelfHook,
  libz,
  ...
}:
let
  pyversion = with builtins; substring 0 3 (replaceStrings [ "." ] [ "" ] python.version);
  dist = "cp${pyversion}";
  sha256 =
    {
      "310" = "5fbe6e7acbd0807c27b2d098e8da37ff2ff9b17d0387fccc774b2c7e3b5726b5";
      "311" = "0f2dde3a889cbb25d187d0deab0e1a116583221ff178472b76aee6aaf1ff62cc";
      "312" = "494bb56092a44f64a5a1df2f00bd662a8c406e8bcf3ac577a0371a3eb55a5711";
      "313" = "471d3a2c6e389b8cf1021e058c485247165d6438e441bd566e6321de70b64424";
    }
    .${pyversion};
in

buildPythonPackage rec {
  disabled = pythonOlder "3.10";
  pname = "imas-core";
  version = "5.5.3";
  format = "wheel";
  src = fetchPypi {
    inherit
      version
      format
      dist
      sha256
      ;
    pname = "imas_core";
    python = dist;
    abi = dist;
    platform = "manylinux_2_28_x86_64";
  };
  buildInputs = [ libz ];
  nativeBuildInputs = [ autoPatchelfHook ];
}
