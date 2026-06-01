# Security and Capabilities

## Principles

Skills are instructions plus optional executable resources. Installing or running a skill can affect user data, repositories, networks, and credentials. A package must declare requested capabilities, but the runtime must enforce permissions.

## Capability model

`skill.json` should declare capabilities explicitly:

```json
{
  "capabilities": {
    "filesystem": {
      "read": true,
      "write": false
    },
    "network": false,
    "commands": {
      "execute": true,
      "allowed": ["python", "uv", "bash"]
    },
    "secrets": {
      "reads_secrets": false,
      "writes_secrets": false
    }
  }
}
```

## Runtime enforcement

Runtimes should:

- Show capability prompts before installing untrusted packages.
- Sandbox command execution when possible.
- Deny undeclared filesystem writes by default.
- Deny network access by default unless declared and allowed.
- Avoid injecting secrets into skill context unless explicitly requested by the user.
- Treat `allowed-tools` frontmatter as a compatibility hint, not an enforcement mechanism.

## Path safety

Manifest paths must be relative to the skill package root and must not escape it. These are invalid:

```text
../outside.txt
/etc/passwd
~/secret.txt
```

## Registry integrity

Registries should provide:

- Immutable version artifacts.
- SHA-256 checksums.
- Optional signatures.
- Source repository metadata.
- Deprecation and replacement metadata.

Installers should verify checksums when available and record them in `skills.lock.json`.
