// Opens the Lead Tracker panel in ChatGPT with every saved lead.
tool open_lead_tracker {
  instructions = "Open the Lead Tracker CRM panel and show every saved lead by stage (New, Qualified, Proposal, Won). Use when the user wants to see, open, or set up their CRM or lead tracker. The panel renders the board; summarize it in one short sentence."

  input {
  }

  stack {
    db.query leads {
      sort = {created_at: "asc"}
      return = {type: "list"}
    } as $leads
  }

  response = {action: "list", saved: false, leads: $leads, source: "xano"}
  guid = "THUADYWSQvaC_14ACDaWqM0ot8s"
}
