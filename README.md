# action-semver
 
 This GitHub Action (a composite action) uses Git tags to describe the current version and next major, minor, and patch versions following [Semantic Versioning](https://semver.org/).

## Usage

### Pre-requisites

Your environment must have access to a repository prior to calling this action. Typical use cases involve calling [actions/checkout](https://github.com/actions/checkout) or using the command `git clone` before calling this action in your workflow.

A repository must have tags fetched in order for this action to work correctly. If tags are not fetched—often the default—then this action will report the repository's semantic version as 0.0.0.

If using `actions/checkout`, you can ensure tags are fetched by calling the action with the input `fetch-depth: 0`.

If using `git clone`, do not forget to also fetch tags with the command `git fetch --tags` after cloning your repository.

### Inputs

- `prefix` - A string which prefixes the semantic version in a tag. For a tag named `v1.2.3`, the prefix would be `v`. Default: no prefix.
- `workspace` - Path of a directory containing a Git repository. This path can be relative to the workflow's current working directory, such as when a workflow clones a repository to a child directory. Default: `github.workspace`.

### Outputs

- `core` - The current version core. If the current version were `1.4.9-alpha+20380119`, the version core would be `1.4.9`.
- `pre-release` - The current pre-release version. If the current version were `1.4.9-alpha+20380119`, the pre-release version would be `alpha`.
- `build` - The current build metadata. If the current version were `1.4.9-alpha+20380119`, the build metadata would be `20380119`.
- `next-major` - The next major version. If the current version were `1.4.9`, the next major version would be `2.0.0`.
- `next-minor` - The next minor version. If the current version were `1.4.9`, the next minor version would be `1.5.0`.
- `next-patch` - The next patch version. If the current version were `1.4.9`, the next patch version would be `1.4.10`.

## Examples

### Example 1: Using Git Checkout

In this example, the repository where the workflow file lives is cloned with `actions/checkout`.

```yaml
name: Example
on: workflow_dispatch
jobs:
  example:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - id: semver
        uses: BBBrassil/action-semver@v1
        with:
          prefix: "v"
      - id: output
        run: |
          echo "current:     '${{ steps.semver.outputs.core }}'"
          echo "next major:  '${{ steps.semver.outputs.next-major }}'"
          echo "next minor:  '${{ steps.semver.outputs.next-minor }}'"
          echo "next patch:  '${{ steps.semver.outputs.next-patch }}'"
```

### Example 2: Using Git Clone

In this example, an external repository ([Blender](https://projects.blender.org/blender/blender)) is cloned with `git clone`.

```yaml
on: workflow_dispatch
jobs:
  example:
    runs-on: ubuntu-latest
    steps:
      - id: checkout
        run: |
          git clone https://projects.blender.org/blender/blender --filter=blob:none --single-branch --branch=main
          cd blender
          git fetch --tags
          cd ..
      - id: semver
        uses: BBBrassil/action-semver@v1
        with:
          workspace: "blender"
          prefix: "v"
      - id: output
        run: |
          echo "core:        '${{ steps.semver.outputs.core }}'"
          echo "pre-release: '${{ steps.semver.outputs.pre-release }}'"
          echo "build:       '${{ steps.semver.outputs.build }}'"
```

### Example 3: Working with Multiple Repositories

In this example, two repositories ([Entitas](https://github.com/sschmid/Entitas) and [Flecs](https://github.com/SanderMertens/flecs)) are cloned to separate child directories. One repository uses the prefix "v" for its tags, while the other uses no prefix.

```yaml
on: workflow_dispatch
jobs:
  example:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          repository: "sschmid/Entitas"
          fetch-depth: 0
          sparse-checkout: .github
          path: "entitas"
      - uses: actions/checkout@v4
        with:
          repository: "SanderMertens/flecs"
          fetch-depth: 0
          sparse-checkout: .github
          path: "flecs"
      - id: semver-entitas
        uses: BBBrassil/action-semver@v1
        with:
          workspace: "entitas"
      - id: semver-flecs
        uses: BBBrassil/action-semver@v1
        with:
          workspace: "flecs"
          prefix: "v"
      - run: |
          echo "Entitas: ${{ steps.semver-entitas.outputs.core }}"
          echo "Flecs:   ${{ steps.semver-flecs.outputs.core }}"
```