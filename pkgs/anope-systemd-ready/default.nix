{
  buildGoModule,
  fetchFromGitHub,
  lib,
}:

buildGoModule {
  pname = "anope-systemd-ready";
  version = "0-unstable-2026-09-23";

  src = fetchFromGitHub {
    owner = "awked-com";
    repo = "anope-systemd-ready";
    rev = "8068a661d49eba87a312e0c23af25f4638c7014b";
    hash = "sha256-9ehJF2ym93xU1+Y8MHyAKmyFdYmrAn+agIUf9vlGaUU=";
  };

  vendorHash = "sha256-h63FxvkuWr4hHkz5LD4+F5dC3ql7IThkwh2/GBu1qNE=";
  subPackages = [ "." ];
  env.CGO_ENABLED = 0;
  ldflags = [
    "-s"
    "-w"
  ];
  checkPhase = ''
    runHook preCheck
    go test ./...
    runHook postCheck
  '';

  meta = {
    description = "Systemd readiness and watchdog monitor for Anope synchronization";
    homepage = "https://github.com/awked-com/anope-systemd-ready";
    platforms = lib.platforms.linux;
    mainProgram = "anope-systemd-ready";
  };
}
