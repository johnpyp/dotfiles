{ atomEnv
, libsecret
, autoPatchelfHook
, dpkg
, fetchurl
, makeDesktopItem
, makeWrapper
, stdenv
, lib
, udev
, wrapGAppsHook
, bash
, pkg-config
, xlibs
, glib
, xdg-utils
, gtk3
, libpulseaudio
, libGL
, xorg
, jdk
}:

stdenv.mkDerivation rec {
  name = "gdlauncher";
  version = "1.1.1";

  src = fetchurl {
    url = "https://github.com/gorilla-devs/GDLauncher/releases/download/v${version}/GDLauncher-linux-setup.deb";
    sha256 = "0jszzyhywpazfdwmhilsvv6hxj7rdvdrpj7lnlknk42jdrs276yq";
  };


  # dontBuild = true;
  # dontConfigure = true;
  # dontPatchELF = true;
  dontWrapGApps = true;

  nativeBuildInputs = [ autoPatchelfHook dpkg makeWrapper wrapGAppsHook ];

  buildInputs = atomEnv.packages ++ [ jdk pkg-config xlibs.libxshmfence.out glib xdg-utils libpulseaudio libGL xorg.libXxf86vm ];

  unpackPhase = "dpkg-deb -x $src .";

  installPhase = ''
    mkdir -p $out/bin
    cp -R usr/share opt $out/
    chmod -R g-w "$out"
    # fix the path in the desktop file
    substituteInPlace \
      $out/share/applications/gdlauncher.desktop \
      --replace /opt/ $out/opt/
  '';

  runtimeDependencies = [];

  postFixup = let
    libPath = lib.makeLibraryPath buildInputs;
  in
    ''
      makeWrapper $out/opt/GDLauncher/gdlauncher $out/bin/gdlauncher \
          --set GAME_LIBRARY_PATH /run/opengl-driver/lib:${libPath} \
          --prefix PATH : ${jdk}/bin/:${xorg.xrandr}/bin/ \
          --prefix XDG_DATA_DIRS : "${gtk3}/share/gsettings-schemas/${gtk3.name}/" \
          --prefix LD_LIBRARY_PATH : "${libPath}" \
          "''${gappsWrapperArgs[@]}" \
    '';


  # patchPhase = ''
  #   ${nodePackages.asar}/bin/asar extract opt/VIA/resources/app.asar tmp
  #   # use Nix(OS) paths
  #   echo $(ls tmp)
  #   # sed -i 's|console.log("loading app url")|console.log("loading app url"),A.webContents.openDevTools()|' tmp/app/main.prod.js
  #   # sed -i 's|De=(e,t)=>e.length===t.length&&e.every((e,n)=>t[n]===e)|De=(e, t)=>true|' tmp/app/dist/renderer.prod.js
  #   # sed -i "s|/usr/bin/pkexec|${polkit}/bin/pkexec|" tmp/node_modules/sudo-prompt/index.js
  #   # sed -i "s|/usr/bin/pkexec|/usr/bin/pkexec', '/run/wrappers/bin/pkexec|" tmp/node_modules/sudo-prompt/index.js
  #   # sed -i "s|--disable-internal-agent||" tmp/node_modules/sudo-prompt/index.js
  #   # sed -i 's|/bin/bash|${bash}/bin/bash|' tmp/node_modules/sudo-prompt/index.js
  #   ${nodePackages.asar}/bin/asar pack tmp opt/VIA/resources/app.asar
  #   rm -rf tmp
  # '';

  meta = with lib; {
    description = "GDLauncher is a simple, yet powerful Minecraft custom launcher with a strong focus on the user experience";
    homepage = "https://gdevs.io";
    downloadPage = "https://github.com/gorilla-devs/GDLauncher/releases";
    license = licenses.gpl3;
    maintainers = with maintainers; [ johnpyp ];
    platforms = [ "x86_64-linux" ];
  };
}
