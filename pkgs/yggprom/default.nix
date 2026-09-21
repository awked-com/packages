{
  buildGoModule,
  fetchFromGitHub,
  lib,
}:

buildGoModule {
  pname = "yggprom";
  version = "0-unstable-2026-09-19";

  src = fetchFromGitHub {
    owner = "yggdrasil-network";
    repo = "yggprom";
    rev = "d6924f70ca55d460b4acbc5cee13c84ebc5ce45d";
    hash = "sha256-8BUAz/i6xtI8T4KyP2e3IQRKfhx8sWRgWiwuPNBqZ6s=";
  };

  vendorHash = "sha256-b/6UMBJiRnTkBR6GaAK4cGw/iYGJKi7MUsqAnWhHdrg=";
  subPackages = [ "." ];
  ldflags = [
    "-s"
    "-w"
  ];

  meta = {
    description = "Prometheus exporter for Yggdrasil peer metrics";
    homepage = "https://github.com/yggdrasil-network/yggprom";
    license = lib.licenses.cc0;
    mainProgram = "yggprom";
    platforms = lib.platforms.unix;
  };
}
