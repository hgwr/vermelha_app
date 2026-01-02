# AGENTS.md

## Purpose
This file guides AI coding agents working on Vermelha. Keep work aligned with the v1 spec and the open GitHub issues.

## Source of Truth
- Canonical spec: docs/spec.md
- If code and spec diverge, prefer the spec unless a deliberate change is agreed, then update the spec.

## Spec Alignment Guidance (AI)
- Prioritize the goals stated in the spec overview and a smooth Wizardry-like UX.
- If the current implementation better reflects those goals or reality, update docs/spec.md to match the implementation and note the reason in the issue/PR.
- If the right direction is unclear, open or reference an issue before changing spec or code.

## Issue-Driven Workflow
Always start work from open GitHub issues and keep them updated.

Commands:
- List open issues:
  - gh issue list -R hgwr/vermelha_app
- View an issue:
  - gh issue view <id> -R hgwr/vermelha_app
- Comment and close when done:
  - gh issue comment <id> -R hgwr/vermelha_app -b "summary..."
  - gh issue close <id> -R hgwr/vermelha_app

## GitHub CLI Text Formatting
Avoid literal "\n" showing up in issue/PR bodies. Bash does not expand "\n" inside
double quotes. Prefer body files or $'..' strings.

Examples:
- Issue/PR bodies via heredoc:
  - 
    ```
    cat <<'EOF' | gh issue create -R hgwr/vermelha_app --title "..." --body-file -
    line 1

    line 2
    EOF
    ```
  - 
    ```
    cat <<'EOF' | gh pr create -R hgwr/vermelha_app --title "..." --body-file -
    line 1

    line 2
    EOF
    ```
- Short bodies with escaped newlines:
  - gh issue comment <id> -R hgwr/vermelha_app -b $'line 1\n\nline 2'
  - gh pr comment <id> -R hgwr/vermelha_app -b $'line 1\n\nline 2'

## Branching and Review
When resolving GitHub issues, create a working branch from `main` and open a
pull request for review before merging.
After a pull request is reviewed and the issue acceptance criteria are met,
merge the pull request, link it to the issue, then close the issue.

## CI (GitHub Actions)
Keep a workflow that runs on `pull_request` and `push` to build/test so errors
surface early. For Flutter, use `flutter test` and (if desired) a lightweight
`flutter build` for the target platforms.

## Expectations for Changes
- Follow UI/UX, localization, and gameplay constraints in docs/spec.md.
- Add clear acceptance criteria when creating new issues.
- Ensure Flutter build and tests pass for the changed scope.
- Keep the main flow playable; avoid breaking the core loop.
