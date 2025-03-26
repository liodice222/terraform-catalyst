provider "oci" {

        tenancy_ocid = var.tenancy_ocid

        user_ocid = var.user_ocid

        private_key_path = var.private_key_path

        fingerprint = var.fingerprint

        region = var.region
}

resource "oci_ons_notification_topic" "test_topic" {
        name = "test_ons_topic_tf"
        compartment_id = var.compartment_id
        description = "notification topic"

}

resource "oci_ons_subscription" "test_subscription" {
        topic_id = oci_ons_notification_topic.test_topic.id
        protocol = "EMAIL"
        endpoint = var.notification_endpoint
        compartment_id = var.compartment_id
}

terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">=4.67.3"
    }
  }
  required_version = ">= 1.0.0"
}
