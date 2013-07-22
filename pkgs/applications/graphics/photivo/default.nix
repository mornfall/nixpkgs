{ stdenv, fetchhg, cmake, qt4, fftw, graphicsmagick_q16,
  lcms2, lensfun, pkgconfig, libjpeg, exiv2, liblqr1 }:

stdenv.mkDerivation rec {
  name = "photivo-2013-05-20";

  src = fetchhg {
    url = "http://code.google.com/p/photivo/";
    tag = "b6e851283ac3";
    sha256 = "1wsqisbv6j80aylk4jr83smyzc2n85h98xiiabgpbdxw7q9n15jv";
  };

  nativeBuildInputs = [ cmake pkgconfig ];

  buildInputs = [ qt4 fftw graphicsmagick_q16 lcms2 lensfun libjpeg exiv2 liblqr1 ];
  patchPhase = '' # kinda icky
    sed -e '/("@INSTALL@")/d' \
        -e s,@INSTALL@,$out/share/photivo, \
        -i Sources/ptSettings.cpp
  '';
}
