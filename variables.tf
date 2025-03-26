variable "rule_condition" {
  description = "event types for rule conditions"
  type = string
}

variable "action_type" {
  description = "action in response to event trigger"
  type = string
}
variable "tenancy_ocid" {
    description = "Nacaus 19e tenancy ocid"
}

variable "user_ocid" {
    description = "Lea's user ocid"
}

variable "fingerprint" {
        description = "Lea's fingerprint"
}

variable "private_key_path" {
    description = "path to private key"
}

variable "compartment_id" {
    description = "LeaTesting compartment ocid"
}

variable "notification_endpoint" {description = "admin email"}
