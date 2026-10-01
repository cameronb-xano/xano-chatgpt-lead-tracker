// GET /leads - Every saved lead, oldest first. The plugin calls this when the panel opens.
query leads verb=GET {
  api_group = "LeadTracker"

  input {
  }

  stack {
    function.run "plugin/require_key" as $ok
    db.query leads {
      sort = {created_at: "asc"}
      return = {type: "list"}
    } as $leads
  }

  response = {leads: $leads}
  history = 100
  guid = "CYga6wYfsHyrDcWpiB1FxxQAaEI"
}