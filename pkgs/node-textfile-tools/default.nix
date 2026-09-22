{
  buildGoModule,
  fetchFromGitHub,
  lib,
  btrfs-progs,
}:

buildGoModule {
  pname = "node-textfile-tools";
  version = "0-unstable-2026-09-23";

  src = fetchFromGitHub {
    owner = "awked-com";
    repo = "node-textfile-tools";
    rev = "480ffcb239b606b88ecb7109e265a8c3724222a3";
    hash = "sha256-u2R8Z8I6e1FhbYRebRiD6GgNEg4GpZFRKtXOyFIYYto=";
  };

  vendorHash = "sha256-eXlsu1VXh7SIWcoTsiEv/UTBnZ04tmQTdX8uwkJHFqw=";
  subPackages = [
    "cmd/textfile"
    "cmd/host-metrics"
  ];
  env.CGO_ENABLED = 1;
  buildInputs = [ btrfs-progs ];
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
    description = "Prometheus textfile collectors for systemd jobs, host health, and Btrfs backups";
    homepage = "https://github.com/awked-com/node-textfile-tools";
    platforms = lib.platforms.linux;
    mainProgram = "host-metrics";
  };
}
