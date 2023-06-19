mach-nix.buildPythonPackage {
  src = builtins.fetchGit {
    url = "https://github.com/user/projectname";
    ref = "master";
    # rev = "put_commit_hash_here";
  };
}
