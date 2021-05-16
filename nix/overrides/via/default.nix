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
, nodePackages
, polkit
, bash
, via
, xdg-utils
, hidapi
, libusb
, libudev
, libudev0-shim
, pkg-config
}:

stdenv.mkDerivation rec {
  name = "via";
  version = "1.3.1";

  src = fetchurl {
    url = "https://github.com/the-via/releases/releases/download/v${version}/via-${version}-linux.deb";
    sha256 = "050fph5y674wxd5jsg1nisp3z62w8zhy0c0rp7b9fpjb5sazqbk4";
  };


  dontBuild = true;
  dontConfigure = true;
  dontPatchELF = true;
  dontWrapGApps = true;

  nativeBuildInputs = [ autoPatchelfHook dpkg makeWrapper wrapGAppsHook ];

  buildInputs = atomEnv.packages ++ [ pkg-config polkit xdg-utils hidapi libusb libudev libudev0-shim ];

  unpackPhase = "dpkg-deb -x $src .";

  installPhase = ''
    mkdir -p $out/bin
    cp -R usr/share opt $out/
    chmod -R g-w "$out"
    # fix the path in the desktop file
    substituteInPlace \
      $out/share/applications/via.desktop \
      --replace /opt/ $out/opt/

    # echo 'KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", TAG+="uaccess", TAG+="udev-acl"' > $out/lib/udev/rules.d/92-viia.rules
  '';

  runtimeDependencies = [ (lib.getLib udev) polkit ];

  postFixup = let

    libPath = lib.makeLibraryPath [
      hidapi
      libusb
      libudev # libudev.so.1
      stdenv.cc.cc.lib # libstdc++.so.6
      # saneBackends      # libsane.so.1
    ];
  in
    ''
      makeWrapper $out/opt/VIA/via $out/bin/via \
          --prefix LD_LIBRARY_PATH : "${libPath}" \
          --set DISABLE_SUDO_PROMPT true \
          "''${gappsWrapperArgs[@]}" \
          --add-flags "--no-sandbox --inspect=5858"
    '';


  patchPhase = ''
    ${nodePackages.asar}/bin/asar extract opt/VIA/resources/app.asar tmp
    # use Nix(OS) paths
    echo $(ls tmp)
    # sed -i 's|console.log("loading app url")|console.log("loading app url"),A.webContents.openDevTools()|' tmp/app/main.prod.js
    # sed -i 's|De=(e,t)=>e.length===t.length&&e.every((e,n)=>t[n]===e)|De=(e, t)=>true|' tmp/app/dist/renderer.prod.js
    # sed -i "s|/usr/bin/pkexec|${polkit}/bin/pkexec|" tmp/node_modules/sudo-prompt/index.js
    # sed -i "s|/usr/bin/pkexec|/usr/bin/pkexec', '/run/wrappers/bin/pkexec|" tmp/node_modules/sudo-prompt/index.js
    # sed -i "s|--disable-internal-agent||" tmp/node_modules/sudo-prompt/index.js
    # sed -i 's|/bin/bash|${bash}/bin/bash|' tmp/node_modules/sudo-prompt/index.js
    ${nodePackages.asar}/bin/asar pack tmp opt/VIA/resources/app.asar
    rm -rf tmp
  '';

  meta = with lib; {
    description = "A cross-platform keyboard configurator";
    homepage = "https://caniusevia.com/";
    downloadPage = "https://www.github.com/the-via/releases/releases/latest";
    license = licenses.unfree;
    maintainers = with maintainers; [ johnpyp ];
    platforms = [ "x86_64-linux" ];
  };
}
