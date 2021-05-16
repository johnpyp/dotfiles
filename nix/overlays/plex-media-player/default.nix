self: super: {
  plex-media-player = super.plex-media-player.overrideAttrs (
    old: rec {
      version = "2.58.0";
      vsnHash = "3255f58";

      src = super.fetchFromGitHub {
        owner = "johnpyp";
        repo = "plex-media-player";
        rev = "v${version}-${vsnHash}";
        sha256 = "0500i078lrp62zss0yfpj8kkqrpv1mpim1m4y8vr421c3c46i7y6";
      };
    }
  );
}
