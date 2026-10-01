# Xano Lead Tracker for ChatGPT

A small CRM that runs inside ChatGPT as an app. Everything behind it runs on Xano: the `leads` table, the tool logic, the MCP server ChatGPT connects to, and the static hosting for the panel UI.

This is the demo app from the Xano video "Your Xano app, inside ChatGPT."

## How it works

```
ChatGPT ──MCP──▶ Xano MCP server "Lead Tracker"
                   ├─ open_lead_tracker   → opens the panel with the board
                   ├─ list_leads          → read the board (the panel calls this)
                   ├─ add_lead            → insert a lead
                   ├─ update_lead_stage   → move a lead to New / Qualified / Proposal / Won
                   └─ lead_tracker_panel  → resource: the panel HTML, fetched from Xano static hosting
                 Xano database: leads
```

- **Inline:** `open_lead_tracker` renders the board in the conversation.
- **Side view:** click ChatGPT's "Open app in tab" icon to show the board next to the chat. The panel switches to a full-height layout when the host reports `displayMode: "fullscreen"`.
- **Live sync:** the panel re-reads `list_leads` every 2 s while it's visible. A lead you add or move from the chat appears on the board and is marked "✓ Saved to Xano".
- **Text-only writes:** `add_lead` and `update_lead_stage` have no output template, so ChatGPT replies in text and the open panel updates itself.

## Repo layout

| Path | What it is |
|---|---|
| `xano/workspace/` | XanoScript for the workspace: table, tools, MCP server and REST endpoints |
| `xano/static/` | Built panel (`panel.html`), deployed to a Xano static host |
| `panel/` | Panel source (dependency-free TypeScript and CSS) and the build script |
| `scripts/seed-demo-leads.sh` | Adds the three demo leads through the MCP server |

## Setup

1. **Push the workspace.** Use the [Xano CLI](https://docs.xano.com):
   ```sh
   cd xano/workspace
   xano workspace push --dry-run
   xano workspace push
   ```
2. **Build and host the panel.**
   ```sh
   cd panel
   npm install
   npm run build
   cd ../xano/static
   xano static_host build push <your-static-host>
   xano static_host deploy <your-static-host> --build_id <id> --env prod
   ```
   Then point the `api.request` URL in `xano/workspace/ai/tool/lead_tracker_panel.xs` at your static host's `panel.html`.
3. **Connect ChatGPT.**
   1. In ChatGPT (developer mode), go to Settings → Plugins and add an app.
   2. Use your MCP server's stream URL, with no authentication.
   3. After any change to tools or the panel, open the app and click **Refresh tools**.
   4. ChatGPT caches the panel by its resource URI. If an old panel keeps showing, bump the `ui://…` URI.
4. **Seed the demo data** (optional):
   ```sh
   MCP_URL=https://<instance>/x2/mcp/lead-tracker-chatgpt/mcp/stream ./scripts/seed-demo-leads.sh
   ```

## Notes

- The `lead_tracker` and `demo_tools` REST endpoints require an `X-Plugin-Key` header. They check it against the workspace env var `PLUGIN_API_KEY`, which isn't in this repo.
- The MCP server has no authentication, which is fine for a demo. Add auth before you put real customer data behind it.
