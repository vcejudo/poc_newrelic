resource "newrelic_alert_policy" "alert_policy" {
  name = "PDF processing - Too many documents failing"
}

resource "newrelic_nrql_alert_condition" "alert_condition" {
  account_id                     = var.newrelic_account_id
  policy_id                      = newrelic_alert_policy.alert_policy.id
  type                           = "static"
  name                           = "PDF processing errors"
  description                    = "PDF processing - Too many documents failing"
  enabled                        = true
  violation_time_limit_seconds   = 3600
  fill_option                    = "static"
  fill_value                     = 1.0
  aggregation_window             = 60
  aggregation_method             = "event_flow"
  aggregation_delay              = 1 /*minute*/ * 60 /*seconds*/
  expiration_duration            = 1 /*minute*/ * 60 /*seconds*/
  open_violation_on_expiration   = false
  close_violations_on_expiration = false
  value_function                 = "single_value"

  nrql {
    query = "SELECT count(*) FROM PoCCustomEvent"
  }

  critical {
    operator              = "above"
    threshold             = 15
    threshold_duration    = 60 /*seconds*/
    threshold_occurrences = "ALL"
  }

  warning {
    operator              = "above"
    threshold             = 25
    threshold_duration    = 60 /*seconds*/
    threshold_occurrences = "ALL"
  }
}


# Creates an email alert channel.
resource "newrelic_alert_channel" "emailing" {
  name = "Notification via email"
  type = "email"

  config {
    recipients              = var.email_recipient
    include_json_attachment = "false"
  }
}

resource "newrelic_alert_policy_channel" "foo" {
  policy_id = newrelic_alert_policy.alert_policy.id
  channel_ids = [
    newrelic_alert_channel.emailing.id
  ]
}
