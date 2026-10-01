// POST /leads - Save a new lead from ChatGPT.
query leads verb=POST {
  api_group = "LeadTracker"

  input {
    text name filters=trim
    text company filters=trim
    decimal deal_value?
    enum stage?=New {
      values = ["New", "Qualified", "Proposal", "Won"]
    }
  }

  stack {
    function.run "plugin/require_key" as $ok
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
  }

  response = $lead
  history = 100
  guid = "B6xRbyxvYONXRzYsi-5N_Mpl_8c"
}