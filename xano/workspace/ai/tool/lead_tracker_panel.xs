// The Lead Tracker panel UI. Served as an MCP resource; the HTML lives on Xano static hosting.
tool lead_tracker_panel {
  instructions = "The Lead Tracker panel (HTML) that ChatGPT renders next to the conversation."

  input {
  }

  stack {
    api.request {
      url = "https://3fgm28-xxmf-qrth-inat.n7d.xano.io/panel.html"
      method = "GET"
      timeout = 15
    } as $page
  
    var $panel {
      value = {
        uri     : "ui://lead-tracker/panel-v3.html"
        mimeType: "text/html;profile=mcp-app"
        text    : $page.response.result
        _meta   : {ui: {prefersBorder: true}, "openai/widgetPrefersBorder": true, "openai/widgetDescription": "Lead Tracker board: every lead by stage, saved in Xano."}
      }
    }
  }

  response = $panel
  guid = "o_JkxVl8SZJRzr9RQmPIvzO2nG0"
}
