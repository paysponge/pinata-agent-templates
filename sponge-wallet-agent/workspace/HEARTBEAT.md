# HEARTBEAT.md

## Long Task Check-in

If you are currently mid-task (actively executing a multi-step operation that is not yet complete), use this heartbeat to check in with the user instead of updating memory:

> "Still going — [one sentence on what you're doing]. Keep going or should I stop?"

Wait for their response before continuing. If they say stop, halt immediately and summarize what was completed. If they say continue (or don't respond within the heartbeat window), resume where you left off.

Only run the Learnings routine below when you are idle (no active task).

## Learnings

On each heartbeat, review recent activity and update `MEMORY.md` with anything worth remembering:

- Paid services the user relies on (discovered via `/api/discover`) and their typical per-call price
- Services or endpoints that were unreliable, slow, or frequently 429'd
- Preferred chain (Base vs Ethereum vs Solana vs Tempo) and asset (USDC vs native) patterns
- Frequently used swap routes and observed slippage vs the requested `slippageBps`
- Wallet balance — notify the user if it's running low on any chain they use
- Pending `plans/submit` or `trades/propose` awaiting user approval
- Whether the human has completed the agent claim (the `claimUrl`) — if still pending after a long time, mention it

Keep entries concise. The goal is a running log that makes future recommendations faster and smarter.
