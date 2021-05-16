{ lib
, fetchFromGitHub
, python3Packages
, importlib-metadata
}:

with python3Packages;

buildPythonApplication rec {
  pname = "ghstack";
  version = "0.4.1";

  disabled = pythonOlder "3.6"; # requires python version >=3.6,<4.0

  src = fetchFromGitHub {
    owner = "johnpyp";
    repo = pname;
    rev = "64a1035cea2edb4676c50fffda06d2fda300474d";
    sha256 = "686cdadf7a53e41c5497d441424e0a07adf3bb611aa151a576de59b71557fe78";
  };

  nativeBuildInputs = [ poetry-core ];

  format = "pyproject";

  # # Package conditions to handle
  # # might have to sed setup.py and egg.info in patchPhase
  # # sed -i "s/<package>.../<package>/"
  # aiohttp>=3,<4
  # importlib-metadata>=3,<4
  # requests>=2,<3
  # typing-extensions>=3,<4
  # # Extra packages (may not be necessary)
  # dataclasses>=0.8,<0.9 # :python_version < "3.7"
  propagatedBuildInputs = [
    aiohttp
    pylint
    requests
    importlib-metadata
  ];

  meta = with lib; {
    description = "Stack diff support for GitHub";
    homepage = https://github.com/johnpyp/ghstack;
    license = licenses.mit;
    maintainers = [ maintainers.johnpyp ];
  };
}
