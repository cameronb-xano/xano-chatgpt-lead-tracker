// Returns every saved lead. The panel calls this when it opens or refreshes.
tool list_leads {
  instructions = "List every lead saved in the Lead Tracker, oldest first, with name, company, deal value and stage."

  input {
  }

  stack {
    db.query leads {
      sort = {created_at: "asc"}
      return = {type: "list"}
    } as $leads
  }

  response = {action: "list", saved: false, leads: $leads, source: "xano"}
  guid = "w8NdDBV0e77_kf1kTLsAky3a_-Y"
}
