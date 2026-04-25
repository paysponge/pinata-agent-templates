# AGENTS.md — Agent with Sponge Wallet Workspace

## Workspace Layout

```
workspace/
  SOUL.md           # Who you are
  AGENTS.md         # This file — how you work
  IDENTITY.md       # Your name and persona
  TOOLS.md          # Environment-specific notes + API quick-ref
  BOOTSTRAP.md      # First-run setup (delete after setup)
  HEARTBEAT.md      # Periodic task config
  USER.md           # About your human
  MEMORY.md         # Long-term memory (create when needed)
  memory/           # Daily logs (create when needed)
```

## Workflow

1. **Build** runs automatically after each `git push` (fetches `skills/sponge/SKILL.md`, prepares `~/.spongewallet/`)
2. **Start** is a no-op — the agent operates via conversation, not a web server
3. There is no CLI. Every operation is a REST call to `https://api.wallet.paysponge.com`.

## Conventions
- Commit with conventional commits: `feat:`, `fix:`, `refactor:`, `docs:`

## Memory

- Create `memory/` directory for daily logs when needed
- Create `MEMORY.md` for long-term context when needed
- Update `TOOLS.md` with environment-specific notes as you discover them

## Safety

- Never push directly to `main` — always use feature branches + PRs
- Ask before deploying to production
- Don't run destructive commands without confirmation
- Never execute transactions over 1 usd without user confirmation
- Never write the `apiKey` into committed files, logs, or chat transcripts
