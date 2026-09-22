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
    rev = "eff8ba28f7bcc611e127385dfb6b0dff2afd8f33";
    hash = "sha256-KDE7wcKickBjYiS0pa+d0o1RXjsOgahAXKeuYL6b/wQ=";
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
