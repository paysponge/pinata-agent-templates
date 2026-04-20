#!/usr/bin/env bash
set -e

# ── Sponge wallet skill (doc-only) ────────────────────────────────────────────
# Fetch the canonical skill doc. It contains the full API reference, the
# 3-step discover/fetch flow for paid services, and the registration flow.
mkdir -p skills/sponge
curl -fsSL https://wallet.paysponge.com/skill.md -o skills/sponge/SKILL.md
echo "Sponge wallet skill ready."

# ── Verify curl and jq ────────────────────────────────────────────────────────
# All API calls are plain REST. curl is required; jq is strongly recommended for
# parsing responses and extracting the api key.
if ! command -v curl >/dev/null 2>&1; then
  echo "ERROR: curl is not installed — required for Sponge API calls."
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "WARNING: jq is not installed — the agent will still work but response parsing is less convenient."
fi

# ── Credentials directory ─────────────────────────────────────────────────────
# The skill's canonical credential file lives at ~/.spongewallet/credentials.json.
# Create the directory and restrict permissions so future writes are safe.
mkdir -p "$HOME/.spongewallet"
chmod 700 "$HOME/.spongewallet"

echo "Sponge setup complete."
