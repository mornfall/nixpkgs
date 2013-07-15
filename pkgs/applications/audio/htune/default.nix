{ cabal, alsaPcm, carray, fft, gloss }:

cabal.mkDerivation (self: {
  pname = "htune";
  version = "0.2";
  sha256 = "1il1d8b7xyv59f7xim337zyh88s1qchsrdhrgmv322hqf73n6rh2";
  isLibrary = false;
  isExecutable = true;
  buildDepends = [ alsaPcm carray fft gloss ];
  meta = {
    description = "harmonic analyser and tuner for musical instruments";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
