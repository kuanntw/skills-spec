# CLI Behavior

## Command name

The reference command name is `skills`. Implementations may use another binary name but should preserve the command semantics below.

## Common commands

| Command | Behavior |
| --- | --- |
| `skills init <name>` | Create a new skill package skeleton. |
| `skills validate <path>` | Validate package structure, `SKILL.md`, `skill.json`, and schemas. |
| `skills list` | List discovered skills. |
| `skills info <name>` | Show metadata and installation scope. |
| `skills activate <name>` | Print or return the selected skill instructions. |
| `skills resources <name>` | List references, scripts, and assets. |
| `skills run <name> <command>` | Execute a command declared in `skill.json`. |
| `skills pack <path>` | Build a distributable archive. |
| `skills install <source>` | Install from a path, archive, Git source, or registry coordinate. |
| `skills update [name]` | Update one or more installed skills according to policy. |
| `skills outdated` | Report available updates. |
| `skills pin <name>@<version>` | Pin a skill version in the lockfile. |
| `skills eval <path>` | Run skill evaluations if `evals.json` exists. |

## Validation requirements

`skills validate` must check:

1. Package directory name is a valid skill name.
2. `SKILL.md` exists.
3. `SKILL.md` has YAML frontmatter.
4. Frontmatter has `name` and `description`.
5. Directory name, frontmatter `name`, and manifest `name` match when `skill.json` exists.
6. `description` is non-empty and within implementation limits.
7. `skill.json` conforms to `skill.schema.json` when present.
8. Relative paths in `entrypoint`, commands, assets, and references do not escape the package directory.
9. Declared command runners reference existing files when they use local scripts.
10. Version fields use SemVer.

## Activation output

`skills activate <name>` should support at least two output modes:

```bash
skills activate code-review --format markdown
skills activate code-review --format json
```

JSON output should include:

```json
{
  "name": "code-review",
  "version": "1.0.0",
  "entrypoint": "SKILL.md",
  "instructions": "...markdown body...",
  "resources": {
    "references": [],
    "scripts": [],
    "assets": []
  }
}
```

## Installation scopes

Install commands should support at least:

| Scope | Location |
| --- | --- |
| `project` | `.agents/skills/` |
| `user` | `~/.agents/skills/` |

Compatibility installers may also write `.claude/skills/`, but neutral tooling should default to `.agents/skills/`.

## Lockfile

Project installs should write `skills.lock.json` when a package comes from a registry, Git source, or archive.

The lockfile records exact versions, checksums, source URLs, and install timestamps so installs are reproducible.
