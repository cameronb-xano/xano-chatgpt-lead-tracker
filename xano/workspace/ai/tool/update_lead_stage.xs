// Moves a lead to another pipeline stage. Finds it by name (or id).
tool update_lead_stage {
  instructions = "Move an existing lead to another stage (New, Qualified, Proposal, Won). Pass the lead's name as the user said it, e.g. 'Maya'. The move is only saved once this tool returns saved=true."

  input {
    text lead_name? filters=trim {
      description = "Name of the lead to move, e.g. Maya or Maya Chen"
    }
  
    int lead_id? {
      description = "Optional: the lead's id, if known"
    }
  
    enum stage {
      description = "The stage to move the lead to"
      values = ["New", "Qualified", "Proposal", "Won"]
    }
  }

  stack {
    db.query leads {
      where = $db.leads.id ==? $input.lead_id && $db.leads.name includes? $input.lead_name
      sort = {updated_at: "desc"}
      return = {type: "single"}
    } as $current
  
    precondition ($current != null) {
      error_type = "notfound"
      error = "No lead matches that name. Call list_leads to see the saved leads."
    }
  
    db.patch leads {
      field_name = "id"
      field_value = $current.id
      data = {stage: $input.stage, updated_at: now}
    } as $lead
  
    db.query leads {
      sort = {created_at: "asc"}
      return = {type: "list"}
    } as $leads
  }

  response = {action: "move", saved: true, lead: $lead, from_stage: $current.stage, leads: $leads, source: "xano"}
  guid = "EhUF64qphPyBTy3VLIYfBPDH9n4"
}
