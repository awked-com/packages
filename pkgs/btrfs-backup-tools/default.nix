{
  buildGoModule,
  fetchFromGitHub,
  lib,
  btrfs-progs,
}:

buildGoModule (finalAttrs: {
  pname = "btrfs-backup-tools";
  version = "0.1.0";
  src = fetchFromGitHub {
    owner = "awked-com";
    repo = "btrfs-backup-tools";
    tag = "v${finalAttrs.version}";
    hash = "sha256-kuWTpNHGXlaHq/R+Aouvs6y1mGKrGskyTT6/gzVoFLY=";
  };
  vendorHash = "sha256-N4uRHKkCULkvUcC5JXTVSpkQpzUsuvEzGKAYtWiFNzc=";
  subPackages = [
    "cmd/backup-info"
    "cmd/backup-ssh-filter"
    "cmd/backup-confined-receive"
    "cmd/backup-window"
    "cmd/backup-retention"
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
    description = "Confined Btrfs backup receivers, retention, and transfer windows";
    homepage = "https://github.com/awked-com/btrfs-backup-tools";
    platforms = lib.platforms.linux;
    mainProgram = "backup-retention";
  };
})
