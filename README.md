# awked-com packages

Nix packages for Anope, UnrealIRCd, Yggprom,
[pinned-bind-sources](https://github.com/awked-com/pinned-bind-sources),
[btrfs-backup-tools](https://github.com/awked-com/btrfs-backup-tools),
[nix-ci-worker](https://github.com/awked-com/nix-ci-worker),
[node-textfile-tools](https://github.com/awked-com/node-textfile-tools),
[anope-systemd-ready](https://github.com/awked-com/anope-systemd-ready), and
[overlay](https://github.com/awked-com/overlay).

## Use

```nix
inputs.awked-packages = {
  url = "github:awked-com/packages";
  inputs.nixpkgs.follows = "nixpkgs";
};
# In a NixOS module:
nixpkgs.overlays = [ inputs.awked-packages.overlays.default ];
```

Or build directly: `nix build github:awked-com/packages#yggprom`.
Recipes under `pkgs/` also work with `pkgs.callPackage`.

Install the patch maintenance command with `nix profile add github:awked-com/packages#overlay`,
then select a project with `overlay -C /path/to/project list`. The package includes
Quilt, Nix, archive tools, and shell completions.

Packages support x86_64 Linux, aarch64 Linux, and aarch64 Darwin, except
UnrealIRCd, pinned-bind-sources, btrfs-backup-tools, node-textfile-tools, and
anope-systemd-ready, which are Linux-only. `nix flake check` builds packages for
the current system; CI checks all three systems.

## Updates

**Update packages** runs weekly. Anope, pinned-bind-sources, and btrfs-backup-tools
track stable GitHub releases; UnrealIRCd tracks stable version 6 releases from
its official JSON feed. Other packages track commits. The workflow refreshes
source and dependency hashes with `nix-update`, builds each package on x86_64
Linux, and opens one PR per package. **Update nixpkgs** runs monthly. Both support
manual runs.

Automation requires the repository Actions setting **Allow GitHub Actions to
create and approve pull requests**. Update workflows dispatch **Check** on their
branches because PRs created with `GITHUB_TOKEN` do not trigger PR workflows.
Review all three platform checks before merging.

Run `nix develop` for `nix-update`, `nixfmt`, and `actionlint`.
