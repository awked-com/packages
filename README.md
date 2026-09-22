# awked-com packages

Standalone Nix packages maintained by [awked-com](https://github.com/awked-com):
Anope, UnrealIRCd, Yggprom,
[pinned-bind-sources](https://github.com/awked-com/pinned-bind-sources),
[btrfs-backup-tools](https://github.com/awked-com/btrfs-backup-tools),
[nix-ci-worker](https://github.com/awked-com/nix-ci-worker),
[node-textfile-tools](https://github.com/awked-com/node-textfile-tools),
[anope-systemd-ready](https://github.com/awked-com/anope-systemd-ready), and
[overlay](https://github.com/awked-com/overlay).
Upstream overrides and deployment-specific patches remain with their consumers.
No local patch files are included here.

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

Outputs cover x86_64 Linux, aarch64 Linux, and aarch64 Darwin, filtered by each
package's supported platforms. UnrealIRCd, pinned-bind-sources, btrfs-backup-tools,
node-textfile-tools, and anope-systemd-ready are Linux-only. `nix flake check` builds
the packages for the current system; CI checks all three systems.

## Updates

The weekly **Update packages** workflow detects stable Anope releases, stable
UnrealIRCd 6 releases from its official JSON feed, and Yggprom, nix-ci-worker,
node-textfile-tools, anope-systemd-ready, and overlay commits. It refreshes
source and dependency hashes with `nix-update`, builds the changed package on
x86_64 Linux, and creates one PR per package. **Update nixpkgs** runs monthly in a
separate PR. The backup and bind-source tools track stable GitHub releases. Both workflows can be run manually.

Automation requires the repository Actions setting **Allow GitHub Actions to
create and approve pull requests**. No personal token is needed. Update workflows
explicitly dispatch **Check** on their branches because PRs created with
`GITHUB_TOKEN` do not trigger PR workflows. Review those three platform results
before merging; updates do not auto-merge.

Run `nix develop` for `nix-update`, `nixfmt`, and `actionlint`.
