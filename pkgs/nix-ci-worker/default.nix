{
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule {
  pname = "nix-ci-worker";
  version = "0-unstable-2026-09-23";

  src = fetchFromGitHub {
    owner = "awked-com";
    repo = "nix-ci-worker";
    rev = "ce26f7d38f5ecc2a8ceeb33954d3ca4953bb0014";
    hash = "sha256-qHwZuftz4mL8eH8i2FeT1kLoRsP5IpHjzGbAIT2D7B4=";
  };

  vendorHash = "sha256-RlhQtMIS/spLuTbgzXPG0t+ouNCAfy5feP1btkFC5+g=";
  subPackages = [ "cmd/nix-ci-worker" ];
  env.CGO_ENABLED = 0;
  ldflags = [
    "-s"
    "-w"
  ];
  # Unit fixtures bind local HTTP servers; native Nix tests run separately.
  __darwinAllowLocalNetworking = true;
  checkPhase = ''
    runHook preCheck
    go test ./...
    runHook postCheck
  '';

  meta = {
    description = "Distributed Nix build workers and encrypted binary caches";
    homepage = "https://github.com/awked-com/nix-ci-worker";
    mainProgram = "nix-ci-worker";
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];
  };
}
