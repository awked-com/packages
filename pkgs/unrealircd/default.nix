{
  c-ares,
  fetchurl,
  jansson,
  lib,
  libargon2,
  libsodium,
  openssl,
  pcre2,
  pkg-config,
  stdenv,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "unrealircd";
  version = "6.2.7";

  src = fetchurl {
    url = "https://www.unrealircd.org/downloads/unrealircd-${finalAttrs.version}.tar.gz";
    hash = "sha256-4HU3X0aTCb8dVBNLyRTsUKSuOwnabS2ywR+fqI1kk3A=";
  };

  nativeBuildInputs = [
    openssl.bin
    pkg-config
  ];
  buildInputs = [
    libargon2
    c-ares
    jansson
    libsodium
    openssl
    pcre2
  ];

  postPatch = ''
    substituteInPlace Makefile.in \
      --replace-fail '$(DESTDIR)@BINDIR@' '@BINDIR@' \
      --replace-fail '$(DESTDIR)@SCRIPTDIR@' '@SCRIPTDIR@' \
      --replace-fail '$(DESTDIR)@DOCDIR@' '@DOCDIR@' \
      --replace-fail '$(DESTDIR)@MODULESDIR@' '@MODULESDIR@'
  '';

  configureFlags = [
    "--build=${stdenv.buildPlatform.config}"
    "--enable-dynamic-linking"
    "--enable-ssl=${openssl.dev}"
    "--with-system-pcre2"
    "--with-system-argon2"
    "--with-system-sodium"
    "--with-system-cares"
    "--with-system-jansson"
    "--with-privatelibdir=no"
    "--with-bindir=${placeholder "out"}/libexec/unrealircd"
    "--with-scriptdir=${placeholder "out"}/bin"
    "--with-confdir=/etc/unrealircd"
    "--with-builddir=/usr/src/unrealircd"
    "--with-modulesdir=${placeholder "out"}/lib/unrealircd/modules"
    "--with-logdir=/var/log/unrealircd"
    "--with-cachedir=/var/cache/unrealircd"
    "--with-tmpdir=/run/unrealircd"
    "--with-datadir=/var/lib/unrealircd"
    "--with-docdir=${placeholder "out"}/share/doc/unrealircd"
    "--with-pidfile=/run/unrealircd/unrealircd.pid"
    "--with-controlfile=/run/unrealircd/unrealircd.ctl"
  ];

  enableParallelBuilding = true;
  installFlags = [ "DESTDIR=${placeholder "out"}" ];

  preInstall = ''
    mkdir -p "$out/bin"
  '';

  meta = {
    description = "High-performance modular IRC server";
    homepage = "https://www.unrealircd.org/";
    license = lib.licenses.gpl2Plus;
    mainProgram = "unrealircd";
    platforms = lib.platforms.linux;
  };
})
