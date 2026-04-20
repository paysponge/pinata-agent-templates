# TOOLS.md — Environment Notes

## Stack

- **Runtime:** shell + `curl` + `jq`
- **API base:** `https://api.wallet.paysponge.com`
- **API version:** `0.2.1` (sent as `Sponge-Version: 0.2.1` on every request)
- **Skill reference:** `skills/sponge/SKILL.md` (canonical source: https://wallet.paysponge.com/skill.md)
- **Credentials:** `~/.spongewallet/credentials.json` (or `SPONGE_API_KEY` env var)
- **Dashboard / funding:** https://wallet.paysponge.com

## Required headers (every request)

```
Authorization: Bearer $SPONGE_API_KEY
Sponge-Version: 0.2.1
Content-Type: application/json
Accept: application/json
```

## Env setup

```bash
export SPONGE_API_URL="https://api.wallet.paysponge.com"
export SPONGE_API_KEY="$(jq -r .apiKey ~/.spongewallet/credentials.json)"
```

## Quick Reference

### Register (first run only)
```bash
curl -sS -X POST "$SPONGE_API_URL/api/agents/register" \
  -H "Sponge-Version: 0.2.1" -H "Content-Type: application/json" \
  -d '{"name":"Agent","agentFirst":true}'
```

### Balances
```bash
curl -sS "$SPONGE_API_URL/api/balances" \
  -H "Authorization: Bearer $SPONGE_API_KEY" -H "Sponge-Version: 0.2.1"

curl -sS "$SPONGE_API_URL/api/balances?chain=base&onlyUsdc=true" \
  -H "Authorization: Bearer $SPONGE_API_KEY" -H "Sponge-Version: 0.2.1"
```

### Transfers
```bash
# EVM (ETH/USDC on ethereum/base)
curl -sS -X POST "$SPONGE_API_URL/api/transfers/evm" \
  -H "Authorization: Bearer $SPONGE_API_KEY" -H "Sponge-Version: 0.2.1" -H "Content-Type: application/json" \
  -d '{"chain":"base","to":"0xabc...","amount":"10","currency":"USDC"}'

# Solana
curl -sS -X POST "$SPONGE_API_URL/api/transfers/solana" \
  -H "Authorization: Bearer $SPONGE_API_KEY" -H "Sponge-Version: 0.2.1" -H "Content-Type: application/json" \
  -d '{"chain":"solana","to":"<address>","amount":"0.5","currency":"SOL"}'
```

### Swaps
```bash
# Solana (Jupiter)
curl -sS -X POST "$SPONGE_API_URL/api/transactions/swap" \
  -H "Authorization: Bearer $SPONGE_API_KEY" -H "Sponge-Version: 0.2.1" -H "Content-Type: application/json" \
  -d '{"chain":"solana","inputToken":"SOL","outputToken":"USDC","amount":"0.5","slippageBps":100}'

# Base (0x)
curl -sS -X POST "$SPONGE_API_URL/api/transactions/base-swap" \
  -H "Authorization: Bearer $SPONGE_API_KEY" -H "Sponge-Version: 0.2.1" -H "Content-Type: application/json" \
  -d '{"chain":"base","inputToken":"ETH","outputToken":"USDC","amount":"0.1","slippageBps":50}'

# Tempo (StablecoinExchange DEX)
curl -sS -X POST "$SPONGE_API_URL/api/transactions/tempo-swap" \
  -H "Authorization: Bearer $SPONGE_API_KEY" -H "Sponge-Version: 0.2.1" -H "Content-Type: application/json" \
  -d '{"chain":"tempo","inputToken":"USDC.e","outputToken":"pathUSD","amount":"10","slippageBps":50}'
```

### Bridge (deBridge)
```bash
curl -sS -X POST "$SPONGE_API_URL/api/transactions/bridge" \
  -H "Authorization: Bearer $SPONGE_API_KEY" -H "Sponge-Version: 0.2.1" -H "Content-Type: application/json" \
  -d '{"sourceChain":"base","destinationChain":"solana","token":"USDC","amount":"25"}'
```

### Paid services — 3-step flow
```bash
# Step 1: discover
curl -sS "$SPONGE_API_URL/api/discover?query=web+search&limit=5" \
  -H "Authorization: Bearer $SPONGE_API_KEY" -H "Sponge-Version: 0.2.1"

# Step 2: service details (REQUIRED)
curl -sS "$SPONGE_API_URL/api/discover/<serviceId>" \
  -H "Authorization: Bearer $SPONGE_API_KEY" -H "Sponge-Version: 0.2.1"

# Step 3: fetch (auto-pays USDC)
curl -sS -X POST "$SPONGE_API_URL/api/x402/fetch" \
  -H "Authorization: Bearer $SPONGE_API_KEY" -H "Sponge-Version: 0.2.1" -H "Content-Type: application/json" \
  -d '{"url":"<baseUrl + path from step 2>","method":"POST","body":{"query":"..."},"preferred_chain":"base"}'
```

### Plans (multi-step with approval)
```bash
curl -sS -X POST "$SPONGE_API_URL/api/plans/submit" \
  -H "Authorization: Bearer $SPONGE_API_KEY" -H "Sponge-Version: 0.2.1" -H "Content-Type: application/json" \
  -d '{
    "title":"Rebalance",
    "reasoning":"...",
    "steps":[
      {"type":"swap","input_token":"SOL","output_token":"USDC","amount":"10","reason":"take profit"},
      {"type":"bridge","source_chain":"solana","destination_chain":"base","token":"USDC","amount":"100","reason":"move to base"}
    ]
  }'

curl -sS -X POST "$SPONGE_API_URL/api/plans/approve" \
  -H "Authorization: Bearer $SPONGE_API_KEY" -H "Sponge-Version: 0.2.1" -H "Content-Type: application/json" \
  -d '{"plan_id":"<id>"}'
```

### Single-trade proposal
```bash
curl -sS -X POST "$SPONGE_API_URL/api/trades/propose" \
  -H "Authorization: Bearer $SPONGE_API_KEY" -H "Sponge-Version: 0.2.1" -H "Content-Type: application/json" \
  -d '{"input_token":"ETH","output_token":"USDC","amount":"0.5","reason":"reduce exposure"}'
```

### Transaction status / history
```bash
curl -sS "$SPONGE_API_URL/api/transactions/status/<txHash>?chain=base" \
  -H "Authorization: Bearer $SPONGE_API_KEY" -H "Sponge-Version: 0.2.1"

curl -sS "$SPONGE_API_URL/api/transactions/history?limit=20&chain=base" \
  -H "Authorization: Bearer $SPONGE_API_KEY" -H "Sponge-Version: 0.2.1"
```

## MCP-only tools

These are documented in `skills/sponge/SKILL.md` and are **not available as REST**:
- `consolidate_usdc` — move scattered USDC onto one chain
- Banking (`bank_onboard`, `bank_status`, `bank_create_virtual_account`, `bank_get_virtual_account`, `bank_list_external_accounts`, `bank_add_external_account`, `bank_send`, `bank_list_transfers`)
- Prepaid cards (`order_prepaid_card`, `get_prepaid_card`, `search_prepaid_card_merchants`)

## Error Handling

Responses are JSON `{"error":"..."}` with standard HTTP codes:
- `400` bad request — check body shape
- `401` invalid key — re-register or refresh creds
- `403` not allowed — address not in allowlist or the human owner hasn't claimed yet
- `429` rate limited — back off and retry
- `5xx` transient — retry with exponential backoff

## Notes

Add environment-specific details here as you discover them:
- SSH hosts, deploy targets
- Pinata agent marketplace deployment details
- Any CI/CD quirks
- Sponge wallet address and balance notes per chain
