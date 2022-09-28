## Policy
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
resource "newrelic_notification_destination" "email_destination" {
  name = "PDF Processing destination email"
  type = "EMAIL"

  property {
    key   = "email"
    value = var.email_recipient
  }
}

resource "newrelic_notification_channel" "email_channel" {
  name           = "PDF Processing destination"
  type           = "EMAIL"
  destination_id = newrelic_notification_destination.email_destination.id
  product        = "IINT" # IINT is Workflows

  property {
    key   = "subject"
    value = "PDF Processing error"
  }
}

resource "newrelic_workflow" "alert_workflow" {
  name                  = "PDF Processing Workflow"
  enrichments_enabled   = true
  destinations_enabled  = true
  enabled               = true
  muting_rules_handling = "NOTIFY_ALL_ISSUES"

  issues_filter {
    name = "filter-name"
    type = "FILTER"

    predicate {
      attribute = "labels.policyIds"
      operator  = "EXACTLY_MATCHES"
      values    = [split(":", newrelic_nrql_alert_condition.alert_condition.id)[0]]
    }
  }

  destination {
    channel_id = newrelic_notification_channel.email_channel.id
  }
}
