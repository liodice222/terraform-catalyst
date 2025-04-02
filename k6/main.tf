# creation steps: 
# OCI image - optional,
# VCN
# IG 
# RT
# public subnet
# private subnet, skipped
# secuirty list - open ports for grafana and Flask, incoming ssh connections tcp 6, open all egress 
# flask app instance 
# grafana instance

provider "oci" {

        tenancy_ocid = var.tenancy_ocid

        user_ocid = var.user_ocid

        private_key_path = var.private_key_path

        fingerprint = var.fingerprint

        region = var.region
}

# OCI image - may be more useful later 

# create VCN
data "oci_core_vcn" "k6_vcn" {
    #Required
    vcn_id = oci_core_vcn.k6_vcn.id
}

# create internet gateway
resource "oci_core_internet_gateway" "k6_internet_gateway" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.k6_vcn.id

    #Optional
    display_name = "K6 Internet Gateway"
    route_table_id = oci_core_route_table.k6_route_table.id
}

# create route tables
resource "oci_core_route_table" "k6_route_table" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.k6_vcn.id

    #Optional
    display_name = "K6 Route Table"
    route_rules {
        destination = "0.0.0.0/0"
        network_entity_id = oci_core_internet_gateway.k6_internet_gateway.id

    }
}

#create public subnet
resource "oci_core_subnet" "public_subnet" {
    #Required
    cidr_block = "10.0.1.0/24"
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.k6_vcn.id
    display_name = "Public Subnet"
    route_table_id = oci_core_route_table.k6_route_table.id
    security_list_ids = [oci_core_security_list.security_list.id]
}

#create security lists



terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">=4.67.3"
    }
  }
  required_version = ">= 1.0.0"
}
