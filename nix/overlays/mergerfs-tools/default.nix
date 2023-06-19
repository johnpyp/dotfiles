self: super: {
  mergerfs-tools = super.mergerfs-tools.overrideAttrs (
    old: rec {
      version = "20221029";

      src = super.fetchFromGitHub {
        owner = "trapexit";
        repo = "mergerfs-tools";
        rev = "ff4ef0355f699eb11f0d75471d3df44c303830a3";
        hash = "sha256-2dyOJMAG9aBWu6Qrxr+W49IuZPm3N9VjTCsr7cwKzoo=";
      };

      postInstall = with super.lib; ''
        wrapProgram $out/bin/mergerfs.balance --prefix PATH : ${makeBinPath [ super.rsync ]}
        wrapProgram $out/bin/mergerfs.dup --prefix PATH : ${makeBinPath [ super.rsync ]}
        wrapProgram $out/bin/mergerfs.consolidate --prefix PATH : ${makeBinPath [ super.rsync ]}
        wrapProgram $out/bin/mergerfs.mktrash --prefix PATH : ${makeBinPath [ super.python3.pkgs.xattr ]}
      '';

    }
  );
}
