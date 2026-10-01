// Lead Tracker: a CRM inside ChatGPT. Data, logic, MCP server and panel all run on Xano.
mcp_server "Lead Tracker" {
  canonical = "lead-tracker-chatgpt"
  description = "ChatGPT app: tools + panel for the leads table"
  instructions = """
    Lead Tracker is a simple CRM. Leads have a name, company, deal value and a stage: New, Qualified, Proposal or Won.
    - To show or set up the CRM, call open_lead_tracker.
    - To add a lead, call add_lead. To move one, call update_lead_stage with the lead's name.
    - Only say a lead was saved after the tool returns saved=true.
    - The open Lead Tracker panel updates itself from Xano, so after add_lead or update_lead_stage just confirm in one short sentence. Do not reopen the panel.
    """
  tags = ["chatgpt", "crm"]
  tools = [
    {name: "open_lead_tracker", tool_meta: "{\"ui\":{\"resourceUri\":\"ui://lead-tracker/panel-v3.html\"},\"openai/outputTemplate\":\"ui://lead-tracker/panel-v3.html\",\"openai/widgetAccessible\":true}"}
    {name: "list_leads", tool_meta: "{\"openai/widgetAccessible\":true}"}
    {name: "add_lead", tool_meta: "{\"openai/widgetAccessible\":true}"}
    {name: "update_lead_stage", tool_meta: "{\"openai/widgetAccessible\":true}"}
    {name: "lead_tracker_panel", type: "resource", resource_uri: "ui://lead-tracker/panel-v3.html"}
  ]
  guid = "w6FuB2AY7txH0TIHLpuzo5tcrBo"
}
