// Saves a new lead to the leads table.
tool add_lead {
  instructions = "Add a new lead to the Lead Tracker. Use when the user names a person or company to track. Stage defaults to New. The lead is only saved once this tool returns saved=true."

  input {
    text name filters=trim {
      description = "Contact name, e.g. Maya Chen"
    }
  
    text company filters=trim {
      description = "Company the contact works for"
    }
  
    decimal deal_value? {
      description = "Deal value in US dollars, e.g. 4800"
    }
  
    enum stage?=New {
      description = "Pipeline stage"
      values = ["New", "Qualified", "Proposal", "Won"]
    }
  }

  stack {
    precondition ($input.name != "") {
      error_type = "inputerror"
      error = "A lead needs a name"
    }
  
    db.add leads {
      data = {
        name      : $input.name
        company   : $input.company
        deal_value: $input.deal_value
        stage     : $input.stage
        updated_at: now
      }
    } as $lead
  
    db.query leads {
      sort = {created_at: "asc"}
      return = {type: "list"}
    } as $leads
  }

  response = {action: "add", saved: true, lead: $lead, leads: $leads, source: "xano"}
  guid = "DVOWpfDvUfxG9lZTAocMR5TPD7g"
}
