# agent with sponge wallet template

## What this is

A pre-configured agent template backed by the [Sponge wallet API](https://wallet.paysponge.com/skill.md). Deploy it and get an AI agent that can transfer, swap, and bridge tokens across Base, Ethereum, Solana, and Tempo — and pay for x402-protected APIs on your behalf.

No CLI. Every operation is a plain REST call to `https://api.wallet.paysponge.com`.

## What is Sponge?

[Sponge](https://paysponge.com) is financial infrastructure for the agent economy. The wallet API lets agents:

- **Hold and move stablecoins and native tokens** across Base, Ethereum, Solana, and Tempo
- **Swap** on Solana (Jupiter), Base (0x), and Tempo (StablecoinExchange)
- **Bridge** between supported chains via deBridge
- **Discover and pay for x402 APIs** — web search, image generation, scraping, AI, enrichment, and more
- **Create reusable payment links** (x402)
- **Trade on Polymarket and Hyperliquid** via unified `action` endpoints
- **Check out on Amazon**
- **On/off-ramp USD via banking (MCP)** and order prepaid Visa cards (MCP)

The agent loads the canonical skill doc at build time into `skills/sponge/SKILL.md` — that file is the authoritative reference for every endpoint, parameter, and flow.

## Example prompts

**Find and call a paid API**
> "Find a web search API and look up 'best noise cancelling headphones 2026' — show me the cost first"

**Generate an image (paid, via x402)**
> "Discover an image generation service and generate a futuristic city at sunset. Tell me the price before calling it."

**Balances and transfers**
> "Show my balances across all chains, then send 10 USDC on Base to 0xabc..."

**Swap**
> "Swap 1 SOL into USDC on Solana with 1% slippage"

**Bridge**
> "Bridge 25 USDC from Base to Solana"

**Multi-step with approval**
> "Submit a plan to take profit on 10 SOL → USDC then bridge 100 USDC to Base. Wait for my approval."

**Trade proposal**
> "Propose a trade: swap 0.5 ETH → USDC on Base, reason: reduce exposure"

**Polymarket / Hyperliquid**
> "Search Polymarket for 2028 election markets" or "Place a 0.001 BTC limit buy on Hyperliquid at 50000"

## How it works

1. Deploy the template on Pinata and open the chat
2. The agent introduces itself and registers an agent-first Sponge wallet via `POST /api/agents/register` — the API key is returned immediately
3. The agent shares a claim URL — you open it in your browser to link the agent to your Sponge account
4. Fund your Sponge wallet at [wallet.paysponge.com](https://wallet.paysponge.com) (or bridge in USDC from another chain)
5. Ask for anything — the agent picks the right endpoint, shows pricing and route, and executes with your confirmation

Transactions over 1 usd always require explicit confirmation.

## Post-deploy setup

Open the chat — the agent handles everything from there.
