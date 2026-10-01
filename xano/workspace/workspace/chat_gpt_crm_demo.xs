// Isolated ChatGPT plugin demo: lead tracker with Xano persistence
workspace "ChatGPT CRM Demo" {
  acceptance = {ai_terms: false}
  preferences = {
    internal_docs    : false
    track_performance: true
    sql_names        : false
    sql_columns      : true
  }
}