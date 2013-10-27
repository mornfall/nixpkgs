{stdenv, fetchsvn, pkgconfig, lua, fpc, pcre, portaudio, freetype, libpng
, SDL, SDL_image, ffmpeg, sqlite, zlib, libX11 }:

stdenv.mkDerivation rec {
  name = "ultrastardx-1.1";
  src = fetchsvn {
    url = "svn://svn.code.sf.net/p/ultrastardx/svn/trunk";
    rev = "3008";
    sha256 = "0wlyb6dwpbkdyb13j9sy41m3dzhgajjprgmv82h9kqi81a1rxfpm";
  };

  buildInputs = [ pkgconfig fpc pcre portaudio freetype libpng SDL SDL_image ffmpeg
    sqlite lua ];

  # patches = [ ./fix-makefile.diff ];
  # preConfigure = "patch -p1 < debian/patches/usdx-svn-updates.diff";

  # The fpc is not properly wrapped to add -rpath. I add this manually.
  # I even do a trick on lib/lib64 for libgcc, that I expect it will work.
  preBuild = ''
    export NIX_LDFLAGS="$NIX_LDFLAGS -rpath ${SDL}/lib -rpath ${SDL_image}/lib -rpath ${libpng}/lib -rpath ${freetype}/lib -rpath ${portaudio}/lib -rpath ${ffmpeg}/lib -rpath ${zlib}/lib -rpath ${sqlite}/lib -rpath ${libX11}/lib -rpath ${pcre}/lib -rpath ${lua}/lib -rpath ${stdenv.gcc.gcc}/lib64 -rpath ${stdenv.gcc.gcc}/lib"

    sed -i 414,424d Makefile
  '';

  # dlopened libgcc requires the rpath not to be shrinked
  # dontPatchELF = true;

  meta = {
    homepage = http://ultrastardx.sourceforge.net/;
    description = "Free and open source karaoke game";
    license = stdenv.lib.licenses.gpl2Plus;
  };
}
