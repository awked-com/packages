final: prev: {
  overlay = final.callPackage ./pkgs/overlay { };
  nix-ci-worker = final.callPackage ./pkgs/nix-ci-worker { };
  pinned-bind-sources = final.callPackage ./pkgs/pinned-bind-sources { };
  btrfs-backup-tools = final.callPackage ./pkgs/btrfs-backup-tools { };
  node-textfile-tools = final.callPackage ./pkgs/node-textfile-tools { };
  anope-systemd-ready = final.callPackage ./pkgs/anope-systemd-ready { };
  anope = final.callPackage ./pkgs/anope { };
  unrealircd = final.callPackage ./pkgs/unrealircd { };
  yggprom = final.callPackage ./pkgs/yggprom { };
}
