# Skill Evaluation

## Purpose

Evaluations measure whether a skill improves an agent's behavior for realistic tasks. They are optional for minimal packages and recommended for registry-ready packages.

## Directory shape

```text
skill-name/
  evals/
    evals.json
    files/
```

## Evaluation file

`evals.json` contains a suite of prompts, fixtures, and assertions.

```json
{
  "schema_version": "0.1.0",
  "skill_name": "code-review",
  "evals": [
    {
      "id": "detect-security-issue",
      "prompt": "Review this diff for security issues.",
      "files": ["diff.patch"],
      "expected_output": "Actionable findings with severity and filename-only references.",
      "assertions": [
        "Output includes at least one finding.",
        "Each finding has severity.",
        "Each finding cites a filename or line."
      ]
    }
  ]
}
```

## Evaluation modes

CLI tools may support:

```bash
skills eval ./code-review --baseline none
skills eval ./code-review --baseline previous
skills eval ./code-review --baseline without-skill
```

Evaluation reports should include the skill version, model or runtime used, timestamp, prompts, outputs, assertion results, and pass/fail summary. When a report displays referenced files to a user, it should show only filenames, not full paths.
