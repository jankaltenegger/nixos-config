final: prev: {
  ripdrag = prev.ripdrag.overrideAttrs (_old: {
    src = prev.fetchFromGitHub {
      owner = "jankaltenegger";
      repo  = "ripdrag";
      rev   = "cc890944f02b6051ccdb87f5e873be8efaefe5d3";
      hash  = "sha256-on/cBdjFs0HBu/PSwAKnWfmozKoQrGRnpOI5jgdqgfQ=";
    };
  });
}
