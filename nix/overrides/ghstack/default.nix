{ lib
, pkgs
, stdenv
, python3Packages
}:

python3Packages.buildPythonPackage rec {
  pname = "ghstack";
  version = "0.4.1";

  disabled = python3Packages.pythonOlder "3.6";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "0haa5g8j7218fqzymmf196zl3wqx9pykgh9nh3d2azvr0481mpcf";
  };

  doCheck = false;

  nativeBuildInputs = with python3Packages; [ importlib-metadata ];

  propagatedBuildInputs = with python3Packages; [
    aiohttp
    requests
    importlib-metadata
    importlib-resources
  ];

  # dontWrapGApps = true;

  meta = with lib; {
    description = "Submit stacked diffs to GitHub on the command line";
    homepage = "https://github.com/ezyang/ghstack";
    # changelog   = "https://github.com/trigg/Discover";
    license = licenses.mit;
    maintainers = with maintainers; [ johnpyp ];
  };
}
