variable "newrelic_account_id" {
  description = "Id of the NewRelic account"
}

variable "newrelic_api_key" {
  type = string
  description = "API key to access NewRelic"
}

variable "newrelic_region" {
  type = string
  description = "Region for the NewRelic account"
  default = "EU"
}


variable "email_recipient" {
  type = string
  description = "Email recipient for notifications"
}
