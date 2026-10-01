// PATCH /leads/{lead_id}/stage - Move a lead to another stage.
query "leads/{lead_id}/stage" verb=PATCH {
  api_group = "LeadTracker"

  input {
    int lead_id
    enum stage {
      values = ["New", "Qualified", "Proposal", "Won"]
    }
  }

  stack {
    function.run "plugin/require_key" as $ok
    db.get leads {
      field_name = "id"
      field_value = $input.lead_id
    } as $current
  
    precondition ($current != null) {
      error_type = "notfound"
      error = "Lead not found"
    }
  
    db.patch leads {
      field_name = "id"
      field_value = $input.lead_id
      data = {stage: $input.stage, updated_at: now}
    } as $lead
  }

  response = $lead
  history = 100
  guid = "EgxEF5T69g-v9dQjHxA35fb537s"
}