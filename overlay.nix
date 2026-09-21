final: prev: {
  pinned-bind-sources = final.callPackage ./pkgs/pinned-bind-sources { };
  btrfs-backup-tools = final.callPackage ./pkgs/btrfs-backup-tools { };
  anope = final.callPackage ./pkgs/anope { };
  unrealircd = final.callPackage ./pkgs/unrealircd { };
  yggprom = final.callPackage ./pkgs/yggprom { };
}
