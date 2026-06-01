# Language Binding Specification

## Scope

Language bindings provide a consistent programmatic interface to discover, validate, activate, install, update, and run skill packages. Bindings must not reinterpret the skill instructions differently from the core format.

## Required behaviors

Every binding should expose these operations:

| Operation | Description |
| --- | --- |
| `discover(options)` | Scan configured user and project locations for skills. |
| `parse(path)` | Parse `SKILL.md` and optional `skill.json`. |
| `validate(path)` | Return validation errors and warnings. |
| `list()` | Return discovered skills. |
| `get(name)` | Return one skill by name after precedence resolution. |
| `activate(name, options)` | Return instructions and resource metadata. |
| `resources(name)` | Return references, scripts, and assets without loading all contents. |
| `install(source, options)` | Install a package from path, archive, Git, or registry source. |
| `update(name, options)` | Update according to version policy. |
| `pack(path, options)` | Build a distributable archive. |
| `runCommand(name, command, options)` | Execute a declared manifest command. |

## TypeScript example

```ts
import { SkillRegistry } from "@agentskills/sdk";

const registry = await SkillRegistry.discover({
  projectDir: process.cwd(),
  scopes: ["project", "user"]
});

const skill = registry.get("code-review");
const activation = await skill.activate({ mode: "instructions" });
console.log(activation.instructions);
```

## Python example

```python
from agentskills import SkillRegistry

registry = SkillRegistry.discover(
    project_dir=".",
    scopes=["project", "user"],
)

skill = registry.get("code-review")
activation = skill.activate(mode="instructions")
print(activation.instructions)
```

## Go example

```go
registry, err := skills.Discover(skills.DiscoverOptions{
    ProjectDir: ".",
    Scopes: []skills.Scope{skills.Project, skills.User},
})
if err != nil {
    return err
}

skill := registry.Get("code-review")
activation, err := skill.Activate(skills.ActivateOptions{Mode: skills.Instructions})
```

## Naming conventions for generated packages

| Skill name | TypeScript package | Python package | Python module | Go import suffix |
| --- | --- | --- | --- | --- |
| `code-review` | `@agentskills/code-review` | `agentskills-code-review` | `agentskills_code_review` | `/skills/code-review` |

A language binding may expose idiomatic names while preserving the canonical skill name in metadata.

## Error model

Bindings should distinguish:

- Parse errors.
- Validation errors.
- Missing skill errors.
- Version resolution errors.
- Permission denied errors.
- Command execution errors.
- Registry or network errors.

Error objects should include a stable `code`, human-readable `message`, and optional `path` or `skill_name`.
