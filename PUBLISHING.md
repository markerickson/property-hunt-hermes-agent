# Publishing Place Hunt to the Agent Index Leaderboard

This guide outlines how to deploy and publish **Place Hunt** to the [AI Worth Using Agent Index](https://aiworthusing.com/agent-index/publish).

---

## 1. Prerequisites

1. **Docker Desktop** installed and running.
2. **Plow Account & CLI**:
   ```sh
   # Install plow-agents if not installed
   # pip install plow-agents or curl installer from plow-pbc/plow-agents
   plow-agents login
   ```
3. **Plow Latch running on your Mac** (with your `DOMO_DEVICE_UID` and `DOMO_MCP_TOKEN`).

---

## 2. Configure Credentials & Listing Metadata

Copy the example credentials file:
```sh
cp plow-credentials.example plow-credentials
```

Edit `plow-credentials`:
```sh
PLOW_API_BASE=https://api.plow.co
PLOW_AGENT_TOKEN=your_plow_agent_token_here

# Leaderboard Listing:
AGENT_ID=place-hunt
AGENT_NAME=Place Hunt
AGENT_BLURB=Search and map places for groups, homes, camping spots, party parks, and restaurants

# Plow Latch (on your Mac):
DOMO_DEVICE_UID=your_domo_device_uid
DOMO_MCP_TOKEN=your_domo_mcp_token
```

---

## 3. Run the Agent Locally

Start your agent container:
```sh
docker compose up -d
```
*Or using the plow-agents CLI:*
```sh
plow-agents deploy --local --line ln_p1
```

Check the logs to confirm startup and Agent Index registration:
```sh
docker compose logs -f
```

The container automatically:
- Boots supervised under s6-overlay.
- Runs `plow-init` to compose the base persona with `persona.md` and seed `skills/productivity/place-hunt`.
- Starts the `agent-index` background service, which registers `place-hunt` and reports token usage every 5 minutes.

---

## 4. Customize Your Listing on the Leaderboard

To customize your leaderboard listing with your name, blurb, and square logo:

```sh
# Ensure you are logged in to Plow
export PLOW_AGENT_TOKEN=$(cat ~/.config/plow/token 2>/dev/null || grep PLOW_AGENT_TOKEN plow-credentials | cut -d= -f2)

# Register or update your listing with the logo:
python3 agent_index_client.py --register \
  --agent place-hunt \
  --name "Place Hunt" \
  --blurb "Search and map places for groups, homes, camping spots, party parks, and restaurants" \
  --logo ./logo.png
```

### Check What Will Be Reported (Dry Run)
```sh
python3 agent_index_client.py --agent place-hunt --dry-run
```

### Check Status
```sh
python3 agent_index_client.py status
```
- `0`: Successfully registered and reporting.
- `3`: Not registered yet.
- `2`: State file unreadable.

---

## 5. Hackathon & Verification Requirements

To qualify for hackathon prizes and get verified on the leaderboard:
1. **MIT Licensed**: Verified (`LICENSE` file is MIT).
2. **Reporting Token Usage**: Verified (automatic via the `agent-index` background service).
3. **Get Verified**: Join the [AI Worth Using Discord](https://aiworthusing.com/discord) to have your agent verified and enabled for one-click deployment directly from the leaderboard.
