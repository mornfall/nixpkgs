{ cabal, carray, fftw3, ixShapable, storableComplex, syb }:  

cabal.mkDerivation (self: {
  pname = "fft";
  version = "0.1.7.2";
  sha256 = "1jv7j0llqldxbb1xbzzawbxvh600a4j0igyw4cj8sxccm43h1kaq";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [ carray ixShapable storableComplex syb ];
  pkgconfigDepends = [ fftw3 ];
  jailbreak = true;
  meta = {
    description = "Bindings to the FFTW library";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
