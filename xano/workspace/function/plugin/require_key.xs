// Only the Lead Tracker plugin server may call these endpoints. Its key lives in
// the plugin's server environment and in this workspace's env, never in the UI.
function "plugin/require_key" {
  input {
  }

  stack {
    var $headers {
      value = $env.$http_headers
    }
  
    var $sent {
      value = $headers
        |get:"x-plugin-key":($headers|get:"X-Plugin-Key":"")
    }
  
    precondition ($sent != "" && $sent == $env.PLUGIN_API_KEY) {
      error_type = "accessdenied"
      error = "Unknown plugin key"
    }
  }

  response = true
  guid = "q9E3GJYVXWVt-BzoS8W3m2cGzZQ"
}