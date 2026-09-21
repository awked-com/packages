{
  cmake,
  fetchFromGitHub,
  gettext,
  lib,
  stdenv,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "anope";
  version = "2.0.20";

  src = fetchFromGitHub {
    owner = "anope";
    repo = "anope";
    rev = finalAttrs.version;
    hash = "sha256-0wvT3BMAOldLfT3+rEXmPPETpHfBXXUsKh8b7BGFCws=";
  };

  nativeBuildInputs = [
    cmake
    gettext
  ];

  cmakeFlags = [ "-DINSTDIR=${placeholder "out"}" ];

  meta = {
    description = "Set of IRC services";
    homepage = "https://www.anope.org/";
    license = lib.licenses.gpl2Only;
    mainProgram = "services";
    platforms = lib.platforms.unix;
  };
})
