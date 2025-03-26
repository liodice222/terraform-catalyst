# combined .tf file
provider "oci" {

        tenancy_ocid = var.tenancy_ocid

        user_ocid = var.user_ocid

        private_key_path = var.private_key_path

        fingerprint = var.fingerprint

        region = "us-ashburn-1"
}

resource "oci_ons_notification_topic" "Notification Topic" {
        name = "test_ons_topic_tf"
        compartment_id = var.compartment_id
        description = "notification topic"

}

resource "oci_ons_subscription" "Admin Subscription" {
        topic_id = oci_ons_notification_topic.notification_topic.id
        protocol = "EMAIL"
        endpoint = var.notification_endpoint
        compartment_id = var.compartment_id
}


#oci_events_rule
resource "oci_events_rule" "Event Rules" {
        compartment_id = var.compartment_id
        description = "Event Rules including OIC, Exadata, VMware"
        is_enabled = true
        display_name = "Event Rules "
        actions {
                actions {
                        action_type = var.action_type
                        description = "send notification to admin"
                        is_enabled = true
                        topic_id = oci_ons_notification_topic.test_topic.id

                        }
                }
        condition = var.rule_condition
}

 # version requirement

terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">=4.67.3"
    }
  }
  required_version = ">= 1.0.0"
}
