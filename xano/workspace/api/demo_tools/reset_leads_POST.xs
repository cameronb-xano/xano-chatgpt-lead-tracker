// POST /reset_leads - Delete every lead so a new recording take starts from an empty tracker.
query reset_leads verb=POST {
  api_group = "DemoTools"

  input {
  }

  stack {
    function.run "plugin/require_key" as $ok
    db.query leads {
      return = {type: "list"}
    } as $all
  
    foreach ($all) {
      each as $l {
        db.del leads {
          field_name = "id"
          field_value = $l.id
        }
      }
    }
  }

  response = {deleted: $all|count}
  guid = "69jOkZi22FxzRQpYn4-0aoM7BKk"
}