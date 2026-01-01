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

## Game Summary (v1)
- Text-first, Wizardry-like dungeon crawler with FF12 gambit-style auto battle.
- Mobile-first for short sessions.
- Party is exactly 3 members, assigned to Forward/Middle/Rear.
- Auto exploration and auto battle with Pause/Play control.
- Gambit rules are Condition + Target + Action, max 16 per character (configurable later).
- Floor unlock: next floor opens after a set number of battles.
- Camp: unlimited full heal, then return to exploration.
- Locale: Japanese first, prepare for English via i18n.

## UI Flow (v1)
- Title -> City menu.
- City menu -> Tavern / Party / Shop / Dungeon / Save.
- Dungeon select -> Exploration -> Camp or Return to City.
- Character detail -> Gambit editor.

## Data Model Intent (v1)
- PlayerCharacter: job, level, exp, stats, equipment, inventory, gambitSet.
- BattleRule: condition, target, action, priority.
- Party: positions Forward/Middle/Rear.
- GameState: roster, party, gold, maxReachedFloor, activeDungeon.
- LogEntry: Explore/Battle/Loot/System.

## Tech Stack
- Flutter + Provider.
- Local persistence via sqflite (see lib/db).

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

## Branching and Review
When resolving GitHub issues, create a working branch from `main` and open a
pull request for review before merging.
After a pull request is reviewed and the issue acceptance criteria are met,
merge the pull request, link it to the issue, then close the issue.

## Expectations for Changes
- Keep UI minimal and mobile-first.
- Use localization resources for labels; do not hard-code English UI strings for v1.
- Add clear acceptance criteria when creating new issues.
- Ensure Flutter build and tests pass for the changed scope.
- Keep the game playable at all times; avoid breaking the main flow.
