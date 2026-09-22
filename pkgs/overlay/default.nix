{
  lib,
  buildGoModule,
  fetchFromGitHub,
  makeWrapper,
  installShellFiles,
  quilt,
  nix,
  gnutar,
  gzip,
  xz,
  bzip2,
  coreutils,
}:

buildGoModule {
  pname = "overlay";
  version = "0-unstable-2026-09-23";

  src = fetchFromGitHub {
    owner = "awked-com";
    repo = "overlay";
    rev = "3a0f8fbe7dd790eb72768330a9af544c0b1e9d95";
    hash = "sha256-5/B9tOq+4E4ODwUvpkDT18W0XAJI1yw2Cq2XzL+7gok=";
  };

  vendorHash = "sha256-0+YEKDc5jW/byxt3mutCh+EIvGm/sVaRoVRgnPBX5ag=";
  subPackages = [ "cmd/overlay" ];
  env.CGO_ENABLED = 0;
  ldflags = [
    "-s"
    "-w"
  ];
  nativeBuildInputs = [
    makeWrapper
    installShellFiles
  ];
  nativeCheckInputs = [ quilt ];
  checkPhase = ''
    runHook preCheck
    go test ./...
    runHook postCheck
  '';
  postInstall = ''
    installShellCompletion --cmd overlay \
      --bash <($out/bin/overlay completion bash) \
      --zsh <($out/bin/overlay completion zsh) \
      --fish <($out/bin/overlay completion fish)
    wrapProgram $out/bin/overlay --prefix PATH : ${
      lib.makeBinPath [
        quilt
        nix
        gnutar
        gzip
        xz
        bzip2
        coreutils
      ]
    }
  '';

  meta = {
    description = "Manage Nix package patch stacks with Quilt";
    homepage = "https://github.com/awked-com/overlay";
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];
    mainProgram = "overlay";
  };
}
