provider "oci" {

        tenancy_ocid = var.tenancy_ocid

        user_ocid = var.user_ocid

        private_key_path = var.private_key_path

        fingerprint = var.fingerprint

        region = var.region
}

resource "oci_events_rule" "test_rules" {
	Compartment_id = var.compartment_id
	description = 
	is_enabled = true
	actions {
		actions {
			Action_type = "ONS"
			description = "send notification"
			Is_enabled = true
			Topic_id = 
		
			}
		}
	condition {
		event_type = [
			"com.oraclecloud.dataflow.createapplication",
			"com.oraclecloud.vmware.createclustertask.begin", 
			"com.oraclecloud.oic.createintegrationinstance.begin",
			"com.oraclecloud.oic.createworkspace.begin",
			"com.oraclecloud.exacc.createcloudexadatainfrastrcture.begin"
			]
		}
	
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">=4.67.3"
    }
  }
  required_version = ">= 1.0.0"
}
