{
  buildGoModule,
  fetchFromGitHub,
  lib,
}:

buildGoModule (finalAttrs: {
  pname = "pinned-bind-sources";
  version = "0.1.1";
  src = fetchFromGitHub {
    owner = "awked-com";
    repo = "pinned-bind-sources";
    tag = "v${finalAttrs.version}";
    hash = "sha256-0TPL7SCmnLBlcluzwcDnPSZBlpXHj1MCdSZvpzlH+GE=";
  };
  vendorHash = "sha256-Np+MQ+oy8nyCBIT1ivJyt0sRpxgGkwGs8M9Je4oLt1I=";
  subPackages = [ "." ];
  env.CGO_ENABLED = 0;
  ldflags = [
    "-s"
    "-w"
  ];
  meta = {
    description = "Pin directory bind mounts without re-resolving source paths";
    homepage = "https://github.com/awked-com/pinned-bind-sources";
    platforms = lib.platforms.linux;
    mainProgram = "pinned-bind-sources";
  };
})
