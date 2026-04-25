# Sponge Wallet Agent

## What is this?

A pre-configured agent template backed by the [Sponge Wallet skill](https://wallet.paysponge.com/skill.md). Deploy it and get an AI agent that can transfer, swap, and bridge tokens across Base, Ethereum, Solana, and Tempo — and pay for x402-protected APIs on your behalf.

No CLI. Every operation is a plain REST call to `https://api.wallet.paysponge.com`. The skill file contains instructions and context on how to call each API endpoint.

## What is Sponge?

[Sponge](https://paysponge.com) gives your agent a securely managed crypto wallet, bank account, and credit card to move money and make payments autonomously, with full observability and controls over every action.

### Key Capabilities

- **Securely managed crypto wallet** with transfers, bridging, swaps, and trading on Hyperliquid and Polymarket
- **Virtual bank accounts** to send and receive ACH and wire transfers
- **Virtual credit cards** to make online payments
- **x402 / MPP payments** to pay for API services without an API key or account
- **Observability and controls** for each action your agent does

The agent loads the canonical skill doc at build time into `skills/sponge/SKILL.md` and uses it as the authoritative reference for every endpoint, parameter, and flow.

## Example prompts

**Balances and transfers**
> "Show my balances across all chains and prepare a 10 USDC transfer on Base"

**Swap token / bridge across chains**
> "Swap 1 SOL into USDC on Solana" or "Bridge 25 USDC from Base to Solana"

**Polymarket / Hyperliquid trading**
> "Search Polymarket for 2028 election markets" or "Place a 0.001 BTC market order on Hyperliquid"

**Send ACH / wire transfers with a virtual bank account**
> "Check my bank account status, get my virtual account details, list linked bank accounts, and prepare a $100 wire transfer. Ask for confirmation before you actually send it."

**Make purchases with a Sponge Card**
> "Create a Sponge Card, get my card details, fund it with $10, and use it to purchase credits on Openrouter."

**Find and call a paid API (via x402 or MPP)**
> "Discover an image generation service and generate a futuristic city at sunset. Tell me the price before calling it."

## How it works

1. Deploy the template on Pinata and open the chat
2. The agent introduces itself and registers an agent-first Sponge Wallet via `POST /api/agents/register` — the API key is returned immediately
3. The agent shares a claim URL — you open it in your browser to link the agent to your Sponge account
4. Fund your Sponge Wallet at [wallet.paysponge.com](https://wallet.paysponge.com) (or transfer crypto from a crypto wallet you own)
5. Ask for anything — check balances and transfer tokens, swap or bridge across chains, trade on Polymarket or Hyperliquid, send ACH/wire transfers from a virtual bank account, fund a Sponge Card to make online purchases, or discover and pay for x402/MPP APIs. The agent picks the right endpoint and executes with your confirmation.

By default, transactions over 1 usd require explicit confirmation. Spending limits and controls are configurable.

## Post-deploy setup

Open the chat and the agent handles everything from there.
