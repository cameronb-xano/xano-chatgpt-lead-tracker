// Leads saved by the Lead Tracker plugin in ChatGPT.
table leads {
  auth = false

  schema {
    int id
    timestamp created_at?=now
  
    // Contact name
    text name filters=trim
  
    // Company the lead works for
    text company filters=trim
  
    // Opportunity size in USD
    decimal deal_value?
  
    // Where the deal sits in the pipeline
    enum stage?=New {
      values = ["New", "Qualified", "Proposal", "Won"]
    }
  
    timestamp updated_at?=now
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "stage"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]

  guid = "hak3yzv47yiy_OAG3lXJhWNNHug"
}