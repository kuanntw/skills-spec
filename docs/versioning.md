# Versioning and Updates

## Version format

Skill package versions must use Semantic Versioning: `MAJOR.MINOR.PATCH`.

Examples:

```text
0.1.0
1.0.0
2.3.4
```

## Version change rules

| Change | Required increment |
| --- | --- |
| Typo fixes, documentation clarification, non-behavioral examples | PATCH |
| New backwards-compatible workflow, command, reference, or asset | MINOR |
| Changed activation criteria, output contract, command contract, security capability, or required input | MAJOR |

For `0.x` versions, consumers should treat minor versions as potentially unstable unless the package declares a stricter compatibility policy.

## Update policy

Packages may declare update behavior in `skill.json`:

```json
{
  "update": {
    "strategy": "semver",
    "channel": "stable",
    "allow_major": false,
    "auto_update": false
  }
}
```

Recommended defaults:

- `strategy`: `semver`
- `channel`: `stable`
- `allow_major`: `false`
- `auto_update`: `false`

## Lockfile

A project can pin installed skills in `skills.lock.json`:

```json
{
  "version": 1,
  "skills": {
    "code-review": {
      "version": "1.2.0",
      "source": "https://registry.example.com/code-review",
      "sha256": "sha256-example",
      "installed_at": "2026-06-01T00:00:00Z"
    }
  }
}
```

CLI tools must not silently rewrite a lockfile to a different major version unless the user explicitly allows major updates.

## Changelog

Registry-ready packages should include `CHANGELOG.md` using this shape:

```markdown
# Changelog

## 1.2.0 - 2026-06-01

### Added

- Add a TypeScript validation runner.

### Changed

- Clarify code review output format.
```
