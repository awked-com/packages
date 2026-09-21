{
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule {
  pname = "nix-ci-worker";
  version = "0-unstable-2026-09-21";

  src = fetchFromGitHub {
    owner = "awked-com";
    repo = "nix-ci-worker";
    rev = "cc0b7ca860cf14e45c7485666a9371f960048914";
    hash = "sha256-HShqAjGr3C+mkWzBkr0Lr6GRdz3VmUeOTrY38+WXqk8=";
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
