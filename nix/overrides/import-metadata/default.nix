{ lib
, buildPythonPackage
, setuptools_scm
, zipp
, pathlib2
, contextlib2
, configparser
, isPy3k
, packaging
, python3Packages
}:

with python3Packages;

buildPythonPackage rec {
  pname = "importlib-metadata";
  version = "1.7.0";

  src = fetchPypi {
    pname = "importlib_metadata";
    inherit version;
    sha256 = "10vz0ydrzspdhdbxrzwr9vhs693hzh4ff71lnqsifvdzvf66bfwh";
  };

  nativeBuildInputs = [ setuptools_scm ];

  propagatedBuildInputs = [ zipp ]
  ++ lib.optionals (!isPy3k) [ pathlib2 contextlib2 configparser ];

  doCheck = false; # Cyclic dependencies.

  # removing test_main.py - it requires 'pyflakefs'
  # and adding `pyflakefs` to `checkInputs` causes infinite recursion.
  preCheck = ''
    rm importlib_metadata/tests/test_main.py
  '';

  meta = with lib; {
    description = "Read metadata from Python packages";
    homepage = "https://importlib-metadata.readthedocs.io/";
    license = licenses.asl20;
  };
}
